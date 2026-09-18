% $Id: mouton.cls,v 1.4 2002/12/06 11:04:49 eyrich Exp $
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{DL}[2008/03/25 v1]
%^^JLaTeX preliminary document class for Data linguistica monographs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - built on top of mouton.cls by Lars Borin 2008-03-25:
% - added BibTeX bibliography style (CL.bst) 2008-03-05
% - adapted to work with XeLaTex and biblatex by Lars and Stian 2022-05-02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------------
\LoadClass[11pt,twoside]{book}
\RequirePackage{calc}
\RequirePackage{fancyhdr}                            % running heads
\RequirePackage{extramarks}                          % running heads
\RequirePackage{caption}
\RequirePackage{verbatim}
\RequirePackage{fontspec}
\setmainfont{Times New Roman}
\RequirePackage[
    natbib=true,
    backend=biber,
    style=langsci-unified,
    citestyle=langsci-unified,
    url=false,
  ]{biblatex}

\setlength\paperwidth{165mm}
\setlength\paperheight{242mm}
%\RequirePackage[cam,a4,center]{crop}
\RequirePackage[off,a4,center]{crop}

% page make-up (A4 is 210x297mm)
\setlength{\parskip}{0\p@}
%\setlength{\belowcaptionskip}{0pt} %\p@} 
\setcounter{secnumdepth}{4}

\normalsize
\setlength{\textheight}{40\baselineskip}\addtolength{\textheight}{\topskip}
\setlength{\textwidth}{120mm}
\setlength{\headheight}{13.59999\p@}
\setlength{\headsep}{14\p@}   
\setlength{\parindent}{5mm}

% center page body on the physical page:
\setlength\@tempdima        {\paperwidth} 
\addtolength\@tempdima      {-\textwidth} 
\setlength\oddsidemargin    {.5\@tempdima}
\addtolength\oddsidemargin  {-1in}
\setlength\marginparwidth   {.5\@tempdima}
\addtolength\marginparwidth {-\marginparsep}
\@settopoint\oddsidemargin 
\@settopoint\marginparwidth
\setlength\evensidemargin  {\oddsidemargin}
\@settopoint\evensidemargin
\addtolength\topmargin{-22.5mm}

% no extra space after sentence-final periods:
\frenchspacing

% set running heads using fancyhdr.sty:
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}\extramarks{}{#1}}
\renewcommand{\sectionmark}[1]{\extramarks{}{\thesection\hspace{0.5em}#1}}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[RO]{\normalsize{\itshape{\lastxmark}}\hspace{1em}\thepage}
\fancyhead[LE]{\normalsize\thepage\hspace{1em}\itshape\leftmark}
\fancypagestyle{plain}{%
\fancyhead{}% 
\renewcommand{\headrulewidth}{0pt}}

% A terrible hack to fix distance between floats and text
% For some reason, \textfloatsep does not seem to be a skip
% anymore, but a command set to 0.7in (about 50pt). Also, it 
% refuses to be reset before \begin{document}, so we cheat and 
% set it in the \frontmatter /LB 2008-04-20
\renewcommand\frontmatter{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \def\textfloatsep{25pt}}

\renewcommand{\bibname}{References}
\newcommand{\references}[1]{%
   \addcontentsline{toc}{chapter}{\numberline{}\refname}%
   \markboth{\refname}{\refname}%
   \extramarks{\refname}{\refname}%
   \bibliography{#1}}

% no running heads on blank pages:
\def\cleardoublepage{%
    \clearpage{\ps@empty\if@twoside\ifodd\c@page\else
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}}

% adjust float parameters
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.9}
\setlength\@fptop{0\p@ }
\setlength\@fpsep{12\p@ }
\setlength\@fpbot{0\p@ plus 1fil }


% Formatting of captions to Data linguistica style
\DeclareCaptionLabelSeparator{cq}{:\quad}
\captionsetup{labelfont={small,rm,it},textfont={small,rm},format=hang,labelsep=cq}

\def\listoftables{\typeout{Warning: You must not use \string\listoftables\space !}%
                   \vskip2ex \texttt{Warning: You must not use
                   \string\listoftables!}\vskip2ex}

% set style of various counters:
\renewcommand\thechapter      {\@arabic\c@chapter}
\renewcommand\thesection      {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thetable        {\thechapter.\@arabic\c@table}
\renewcommand\thefigure       {\thechapter.\@arabic\c@figure}
\renewcommand\theequation     {\@arabic\c@equation}
%%% Bortkommenterad FO 081029
%\renewcommand\thefigure       {\@arabic\c@figure}
%%

%\renewcommand\theappendix     {\@Alph{c@appendix}}
% no period at end of counter in heading
\def\@seccntformat#1{\csname the#1\endcsname\quad}

\@removefromreset{footnote}{chapter}
%%% Bortkommenterad FO 081029
%\@removefromreset{figure}{chapter}
%%%
\@removefromreset{endnote}{chapter}
\@removefromreset{ExNo}{chapter}
\@removefromreset{equation}{chapter}

\def\subtitle#1{\gdef\@subtitle{#1}}
\def\@subtitle{}
\def\pubyear#1{\gdef\pub@year{#1}}
\def\DLno#1{\gdef\@DL{#1}}
\def\ISBN#1{\gdef\@ISBN{#1}}
\def\maketitle{
\begingroup
  \parindent=\z@
  \pretolerance=10000
  \rightskip=\z@ \@plus 3cm
  \newpage\thispagestyle{empty}
  {\sf\LARGE%
    \@author\par
    \vskip\baselineskip%
    {\bfseries \@title\par}\normalsize}
  \newpage\thispagestyle{empty}
  {\sf\huge%
    Data linguistica\par
    \normalsize
    $<$https://www.gu.se/svenska-spraket/data-linguistica$>$\par
    \vskip\baselineskip%
    Editor: Lars Borin\par
    \vskip\baselineskip%
    Spr{\aa}kbanken \par %and the\par 
%    Natural Language Processing Research Unit\par
%    \vskip 0.5\baselineskip
    Department of Swedish\par
    University of Gothenburg\par
    \vskip\baselineskip%
    \Large \@DL\ $\bullet$ \pub@year\par\normalsize}


  \newpage\thispagestyle{empty}
  {\sf\huge
    \@author\par
    \vskip 2cm\Huge
	   {\bfseries \@title}\par\vskip\baselineskip\normalsize}
  \if!\@subtitle!\else
   {\sf\LARGE\ignorespaces\@subtitle \par}
   \vskip 1cm                % Vertical space after subtitle.
  \fi
  \vfill
  {\sf\large\raggedleft Gothenburg \pub@year\par\normalsize}
  \newpage\thispagestyle{empty}
  {\sf\normalsize%
    Data linguistica 1337\par
    ISBN \@ISBN\par
    ISSN 0347-948X\par
    E-publication $<$http://hdl.handle.net/2077/55895$>$ \par
    \vskip\baselineskip
    Printed in Sweden by\par
    Who Knows \pub@year\par
    \vskip\baselineskip
    Typeset in {\LaTeXe} by the author
    \vskip\baselineskip
    Cover design by Picasso\par
    \vskip 0.5\baselineskip
    Front cover illustration by Matisse\par
    %{\em XX}\par
    %by Yy Zz \copyright\par
    \vskip 0.5\baselineskip
    Author photo on back cover by Luis Buñuel\par}
  \newpage\thispagestyle{empty}
\endgroup
 \let\maketitle\relax
 \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}

% short titles for running head //LB 2007-12-14
\def\chptitle#1{%
  \fancyhead[RO]{\normalsize{\itshape{#1}}\hspace{1em}\thepage}}
\def\sectitle#1{%
  \fancyhead[LE]{\normalsize\thepage\hspace{1em}\itshape\thesection\hspace{0.5em}#1}}

%% Chapter headings //LB 2008-03-27
\newlength{\K@pN}
\newlength{\K@pT}
\newsavebox{\K@pnBox}

\newcommand{\skapitel}[1]{%
{\huge\sbox{\K@pnBox}{\resizebox{!}{0.20\textwidth}{\thechapter}}%
\settowidth{\K@pN}{\usebox{\K@pnBox}}%
\setlength{\K@pT}{\textwidth - \K@pN - 10mm}
\begin{tabular}{p{\K@pN}p{\K@pT}}
\cline{2-2}
\usebox{\K@pnBox} & \parbox[b]{\K@pT}{\flushleft \scshape #1} \\
\cline{2-2}
\end{tabular}}}

\newcommand{\nskapitel}[1]{%
{\huge
\begin{tabular}{p{0.15\textwidth}p{0.75\textwidth}}
\cline{2-2}
\mbox{ } & \parbox[b]{0.75\textwidth}{\flushleft \scshape #1}\\
\cline{2-2}
\end{tabular}}}

\def\@makechapterhead#1{%
  \vspace*{20\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter \skapitel{#1} \else \nskapitel{#1} \fi
    \else \nskapitel{#1} \fi 
    \vskip 36\p@
  }}
\def\@makeschapterhead#1{%
  \vspace*{20\p@}%
  {\parindent \z@ \raggedright \normalfont
    \nskapitel{#1}
    \vskip 36\p@
  }}


\renewcommand\section{\@startsection{section}{1}{\z@}%
                                     {-24pt \@plus -1ex \@minus -.3ex}%
                                     {12pt \@plus.2ex}%
                                     {\normalfont\normalsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-24pt \@plus -1ex \@minus -.3ex}%
                                     {12pt \@plus .2ex}%
                                     {\normalfont\normalsize}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-24pt \@plus -1ex \@minus -.3ex}%
                                     {12pt \@plus .2ex}%
                                     {\normalfont\normalsize\itshape}}
\renewcommand\paragraph{\@startsection{paragraph}{3}{\z@}%
                                     {-24pt \@plus -1ex \@minus -.3ex}%
                                     {12pt \@plus .2ex}%
                                     {\normalfont\normalsize\itshape}}
\renewcommand\subparagraph[1]{\typeout{Warning: You must not use \string\subparagraph\space !}%
                   \vskip2ex \texttt{Warning: You must not use
                   \string\subparagraph!}\vskip2ex}

\newcommand{\@beginning}[1]{%
   \cleardoublepage
   \chapter*{#1}
   \addcontentsline{toc}{chapter}{\numberline{}#1}%
   \markboth{#1}{#1}%
   \extramarks{#1}{#1}}

\newenvironment{sammanfattning}%
{\@beginning{Sammanfattning}{}}

\newenvironment{abstract}%
{\@beginning{Abstract}{}}

\newenvironment{preface}%
{\@beginning{Preface}{}}

\newenvironment{acknowledgements}%
{\@beginning{Acknowledgements}{}}

% redefined quote-environment
\renewenvironment{quote}%
{\begin{list}{}{%
      \setlength{\topsep}{13pt plus 3pt minus 3pt}%
      \setlength{\partopsep}{0pt}%
      \setlength{\parsep}{0pt}%      
      \setlength{\rightmargin}{5mm}%
      \setlength{\leftmargin}{5mm}}%
      \setlength{\itemsep}{0pt}%
\item[]}
{\unskip\end{list}}

% table of contents
%\setcounter{tocdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname}%
    \markboth{\contentsname}{\contentsname}%
    \extramarks{\contentsname}{\contentsname}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
%% \newcommand{\references}[1]{%
%%    \addcontentsline{toc}{chapter}{\numberline{}\refname}%
%%    \markboth{\refname}{\refname}%
%%    \extramarks{\refname}{\refname}%
%%    \bibliography{#1}}


% no bold page numbers in the toc:
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{2.5em}% 
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \textbf{#1}\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

\def\l@part#1#2{\addpenalty{\@secpenalty}
   \addvspace{2.0em plus 1pt}  % space above part line
   \begingroup
   \setlength\@tempdima{2em}       % width of box holding part number, used by
     \parindent \z@ \rightskip \@pnumwidth      %% \numberline
     \parfillskip -\@pnumwidth
     {\large         % set line in \large boldface
     \leavevmode        % TeX command to enter horizontal mode.
     \advance\leftskip 2.5em %\@tempdima
%     \hskip -\leftskip
     \textbf{#1}\hfil \hbox to\@pnumwidth{\hss #2}}\par
     \nobreak           % Never break after part entry
   \endgroup}

% formatting of toc entries:
\renewcommand*\l@section{\@dottedtocline{1}{0em}{2.5em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2.5em}{3.5em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{4em}{3em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{0em}{4em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{0em}{4em}}

%====
\def\l@pt#1{\addpenalty{\@secpenalty}
  \addvspace{2.0em plus 1pt}
  \begingroup
  \setlength\@tempdima{2em}
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    {\large
    \leavevmode
    \advance\leftskip 2.5em
    \textbf{#1}\hfil \hbox to\@pnumwidth{\hss {}}}\par
    \nobreak
  \endgroup}

\renewcommand\appendix{\par
 \setcounter{chapter}{0}%
 \setcounter{section}{0}%
 \gdef\@chapapp{\appendixname}%
 \gdef\thechapter{\@Alph\c@chapter}%
 \addtocontents{toc}{\l@pt{Appendices}}}
%==== 

%% 2008-03-25 //LB
\newcommand*\SCduplicate [1] {%
#1%
}
%% -- commented out in order to get biblatex working:
%\bibpunct[: ]{(}{)}{; }{a}{}{, }
%\setlength\bibsep{2pt plus 1pt}
%\setlength\bibhang{2em}
%\setlength{\textfloatsep}{2\baselineskip}

\endinput
