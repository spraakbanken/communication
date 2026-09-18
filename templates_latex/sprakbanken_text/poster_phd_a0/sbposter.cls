\ProvidesClass{sbposter}[Språkbanken Text poster template]

% Language options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tikzposter}}
\ProcessOptions\relax

% For printed posters, replace rgb with cmyk
\PassOptionsToPackage{rgb}{xcolor}

% tikzposter setup
\LoadClass[
  25pt, % fontsize 
  a0paper, % papersize: a0paper, a1paper, or a2paper
  portrait, % orientation: portrait or landscape
  margin=0mm,  % the margin between outer edge of the poster and the edge of the paper
  innermargin=50mm, % the margin from the edge of the poster edge to the outermost edge of the blocks
  blockverticalspace=16mm, % vertical distance between two blocks
  colspace=16mm, % horizontal distance between two columns
  subcolspace=8mm] % horizontal distance between two subcolumns
  {tikzposter}

% Load GU-specific graphic elements
\RequirePackage{sbcolor} 

\definecolorpalette{sb} {
  \definecolor{bgcolor}{named}{gugray}
  \definecolor{txtcolor}{named}{black}
  \definecolor{titlescolor}{named}{black}
}

\definecolorstyle{sb} {}{
  % Background Colors
  \colorlet{backgroundcolor}{bgcolor}
  \colorlet{framecolor}{bgcolor}
  % Title Colors
  \colorlet{titlefgcolor}{titlescolor}
  \colorlet{titlebgcolor}{bgcolor}
  % Block Colors
  \colorlet{blocktitlebgcolor}{white}
  \colorlet{blocktitlefgcolor}{titlescolor}
  \colorlet{blockbodybgcolor}{white}
  \colorlet{blockbodyfgcolor}{black}
  % Innerblock Colors
  \colorlet{innerblocktitlebgcolor}{white}
  \colorlet{innerblocktitlefgcolor}{titlescolor}
  \colorlet{innerblockbodybgcolor}{white}
  \colorlet{innerblockbodyfgcolor}{black}
  % Note colors TODO check what makes sense here
  \colorlet{notefgcolor}{titlescolor}
  \colorlet{notebgcolor}{titlescolor}
  \colorlet{noteframecolor}{txtcolor}
}

\definebackgroundstyle{sb}{
  \draw[inner sep=0pt, line width=0pt] 
  (bottomleft) rectangle (topright);
  \node[inner sep=0pt] (gu) at   
  (0.5\paperwidth-20cm,0.5\paperheight-7.2cm)
      {\includegraphics[width=28cm]{images/sprakbanken_text_gu_en.pdf}};
}

\definebackgroundstyle{sbgray}{
  \draw[inner sep=0pt, line width=0pt, fill=backgroundcolor] 
  (bottomleft) rectangle (topright);
  \node[inner sep=0pt] (gu) at   
  (0.5\paperwidth-20cm,0.5\paperheight-7.2cm)
      {\includegraphics[width=28cm]{images/sprakbanken_text_gu_en.pdf}};
}

\definetitlestyle{sb}{
width=0.85\paperwidth, roundedcorners=0, linewidth=1pt, innersep=0cm,
titletotopverticalspace=5cm, titletoblockverticalspace=2cm
}{}

\renewcommand\TP@maketitle{%
    \begin{minipage}{0.85\titlewidth}
        \color{titlefgcolor}
        {\Huge \textbf{\@title} \par}
        \vspace*{2em}
        % {\textcolor{sborange}{\rule{4cm}{2mm}}\par}
        % \vspace*{1.5em}
        {\huge \@author \par}
        \vspace*{1em}
        {\Large \@institute \par}
        \vspace*{1em}
        {\textcolor{sborange}{\rule{1\titlewidth}{2mm}}\par}
        \vspace*{0.5em}
    \end{minipage}
}

\defineblockstyle{sb}{ 
  titlewidthscale=1,
  bodywidthscale=1,
  titleleft,
  titleoffsetx=0pt,
  titleoffsety=0pt,
  bodyoffsetx=0mm,
  bodyoffsety=15mm,
  bodyverticalshift=5mm,
  roundedcorners=1cm,
  linewidth=0pt,
  titleinnersep=1cm,
  bodyinnersep=1cm
}{
  \draw[color=framecolor, fill=blockbodybgcolor,
  rounded corners=\blockroundedcorners] (blockbody.south west)
  rectangle (blockbody.north east);
  \ifBlockHasTitle
    \draw[color=framecolor, fill=blocktitlebgcolor,
    rounded corners=\blockroundedcorners] (blocktitle.south west) -- 
    (blocktitle.north west) -- (blocktitle.north east) -- (blocktitle.south 
    east);
  \fi
}

% Use the Jost* font
\usepackage{fontspec}
\setmainfont{Jost-500-Medium.otf}
[BoldFont = Jost-700-Bold.otf,
ItalicFont = Jost-500-MediumItalic.otf,
BoldItalicFont  = Jost-700-BoldItalic.otf]

\usepackage{MnSymbol}%
\renewcommand{\labelitemi}{$\blacksquare$}

% Define our SB theme
\definelayouttheme{sb}{
  \usecolorstyle[colorPalette=sb]{sb}
  \usebackgroundstyle{sbgray}
  \usetitlestyle{sb}
  \useblockstyle{sb}
}
\usetheme{sb}

% Remove logotypes etc from lower right
\tikzposterlatexaffectionproofoff


