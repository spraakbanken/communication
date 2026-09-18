% A BibTeX bibliography style
%    originally conforming to the Chicago Manual's A style
%       but with B style author-date citations
%          by Matt Swift <swift@alum.mit.edu>
%
%   Modified by Lars Borin <lars.borin@svenska.gu.se> 
%   to suit diverse purposes beginning October 2004.
%
%   This program is free software; you may redistribute it and/or
%   modify it under the conditions of the LaTeX Project Public
%   License, either version 1.2 or (at your option) any later version.
%   The latest version of this license is in
%   http://www.latex-project.org/lppl.txt, and version 1.2 or later is
%   part of all distributions of LaTeX version 1999/12/01 or later.
%
%   This program is distributed in the hope that it will be useful,
%   but without any warranty; without even the implied warranty of
%   merchantability or fitness for a particular purpose.  See the
%   LaTeX Project Public License for more details.
%

INTEGERS { output.state before.all mid.sentence after.sentence after.block }
INTEGERS { author.ptype editor.ptype organization.ptype key.ptype
           emergency.ptype }
INTEGERS { last.year.tag.num citation.no }
STRINGS  { last.leaditem last.label.and.year following.year.label.tag }
INTEGERS { j nameptr namesleft numnames len }
STRINGS  { s t u v w }

ENTRY
  { address
    annotation
    author
    bookauthor
    booktitle 
    chapter   
    edition   
    editor
    faddress
    flanguage
    fpublisher
    ftitle     
    fyear      
    howpublished
    illustrator
    institution
    journal    
    key        
    month      
    note                      
    number     
    oaddress   
    opublisher 
    organization
    oyear       
    pages
    publisher   
    school
    series      
    seriesedition
    title        
    translator   
    type         
    volume       
    year         
    yearcomp     
  }
  { principal-type }
  { label
    year.label year.label.tag
    principal-field
    leaditem
}

MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}

FUNCTION {debugval}
{  ": [" *
  swap$ *    %$
  "] in " * cite$ *    %$
  top$      %$
}
  
FUNCTION {debugmsg}
{  " in " * cite$ * top$
}

FUNCTION {init.scalars}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=

  #0 'author.ptype :=
  #1 'editor.ptype :=
  #2 'organization.ptype :=
  #3 'key.ptype :=
  #4 'emergency.ptype :=
}

FUNCTION {not}
{   { #0 
    }
    { #1 
    }
  if$                 %$
}

FUNCTION {and}
{   'skip$            %$
    { pop$            %$
      #0 
    }
  if$                 %$
}

FUNCTION {or}
{   { pop$            %$
      #1 
    }
    'skip$            %$
  if$                 %$
}

FUNCTION {comma}
{ ","
}

FUNCTION {period}
{ "."
}

FUNCTION {hyphen}
{ "-"
}

FUNCTION {colon}
{ ":"
}

FUNCTION {space}
{ " "
}

FUNCTION {delimiter.name-part}
{ "  "
}

FUNCTION {delimiter.name}
{ "   "
}

FUNCTION {delimiter.sub-sortkey}
{ "    "
}

FUNCTION {tie}
{ "~"
}

FUNCTION {etal}
{ " et~al."
}

FUNCTION {unidentified} 
{ "HiGHlY*Peco@lIEr" 
}

FUNCTION{output.begin}
{ ""
  before.all 'output.state :=
}
FUNCTION {output.end}
{ write$               %$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$                  %$
    { after.block 'output.state := 
    }
  if$                       %$
}

FUNCTION {in.block}
{ 
  mid.sentence 'output.state := 
}

FUNCTION {new.sentence}
{ output.state before.all = output.state after.block = or
    'skip$              %$
    { after.sentence 'output.state := 
    }
  if$              %$
}

FUNCTION {output.internal}
{ 's :=     % s := string/entry(nonnull)
  space * 't :=     % t := punctuation + space
  output.state mid.sentence =
    { t * write$               %$
    }
    { output.state after.block =
        { add.period$ write$
          newline$              %$
          "\newblock " write$              %$
        }
        { output.state before.all =
            'write$              %$
            { add.period$ space * write$
            }
          if$              %$
        }
      if$              %$
      mid.sentence 'output.state :=
    }
  if$              %$
  s
}

FUNCTION {output}
{ swap$ duplicate$ empty$
    { pop$
      pop$              %$
    }
    'output.internal
  if$              %$
}

FUNCTION {output.bibitem}
{ newline$                 %$
  "\bibitem[\protect\citeauthoryear{" write$          %$
  label write$           %$
  "}{" write$                  %$
  year.label year.label.tag * write$        %$
  "}]{" write$             %$
  cite$ write$                    
  "}" write$               %$
  newline$            %$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$             %$
      "" 
    }
    'skip$             %$
  if$                  %$
}

FUNCTION {italicize}
{ duplicate$ empty$
    { pop$              %$
      "" 
    }
    { "{\em " swap$ * "}" *       %$
    }
  if$                       %$
}

FUNCTION {parenthesize}
{ duplicate$ empty$
    { pop$            %$
      ""
    }
    { "(" swap$ * ")" *         %$
    }
  if$                           %$
}

FUNCTION {format.clip}
{ #1 entry.max$ substring$ 
  #1 global.max$ substring$
}

FUNCTION {format.sortify.clip}
{ % duplicate$ "sinful" debugval %$
  purify$                   %$
  "l" change.case$                   %$
  format.clip
}

FUNCTION {check.empty}
{ 't := 
  duplicate$ empty$
    { "empty " t * " in " * cite$ * warning$ 
    }
    'skip$                              %$
  if$                              %$
}

FUNCTION {multipage.p}
{ pages 't :=
  #0 'j :=
  % WHILE
  {   j not
      t empty$ not            %$
    and
  }
    { t #1 #1 substring$                %$
        duplicate$ hyphen =                  %$
          swap$ duplicate$ comma =
          swap$ "+" =                       %$
        or
      or
        { #1 'j := 
        }
        { t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
  j
}

FUNCTION {format.n.dashify}
{ 't :=
  ""
  % WHILE
  { t empty$ not }                %$
    { t #1 #1 substring$ hyphen =                %$
        { t #1 #2 substring$ "--" = not                %$
            { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    { % WHILE
              { t #1 #1 substring$ hyphen = }                %$
		{ hyphen *
		  t #2 global.max$ substring$ 't :=
		}
	      while$                %$
	    }
	  if$                %$
        }
        { t #1 #1 substring$ *                %$
          t #2 global.max$ substring$ 't :=
        }
      if$                %$
    }
  while$                                  %$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #5 <
    { tie
    }
    { space 
    }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ 
    }
  if$
}

FUNCTION {start.a.q}
{ #-1 'j :=
  ""
}

FUNCTION {inc.j}
{ j #1 + 'j := 
}

FUNCTION {key.q}
{ duplicate$ empty$
    { pop$           %$
      key field.or.null
      inc.j
    }
    'skip$             %$
  if$                  %$
}

FUNCTION {organization.q}
{ duplicate$ empty$
    { pop$                  %$
      organization field.or.null
      inc.j
    }
    'skip$                    %$
  if$                       %$
}

FUNCTION {editor.q}
{ duplicate$ empty$
    { pop$                       %$
      editor field.or.null
      inc.j
    }
    'skip$                       %$
  if$                       %$
}

FUNCTION {author.q}
{ duplicate$ empty$
    { pop$                       %$
      author field.or.null
      inc.j
    }
    'skip$                       %$
  if$                       %$
}

FUNCTION {blank.q}
{ duplicate$ empty$
    'inc.j
    'skip$                       %$
  if$                       %$
}

FUNCTION {check.q}
{ 't :=
  duplicate$ empty$
    { pop$                              %$
      cite$ format.clip 'u :=           %$
      "Need " t * " in " * cite$ * "; using:  " * u * warning$
      u
      inc.j
    }
    'skip$                              %$
  if$                              %$
}    

FUNCTION {format.names.for.label}
{ 's :=
  s num.names$ 'numnames :=                                   %$
  s #1 "{vv~}{ll}" format.name$                                 %$
    s numnames "{ff}{vv}{ll}{jj}" format.name$ "others" =    %$
    numnames #3 >
  or
    % more than 3 names, or final name is "others"
    { etal *
    }
    { numnames #1 - 'namesleft :=
      #2 'nameptr :=
	% WHILE
	{ namesleft #0 > }
	{ nameptr numnames =
	    % we're on the final name (and it's not "others")
%% 10 Oct 2004 / Lars Borin
%	    { numnames #2 >
%		{ comma *
%		}
%		'skip$        %$
%	      if$        %$
%	    {  " \& " * s nameptr "{vv~}{ll}" format.name$ *     %$
	    {  " and " * s nameptr "{vv~}{ll}" format.name$ *     %$
	    }
	    % we're not on the final name (in this case: 2d of 3 names)
	    { comma * space *
	      s nameptr "{vv~}{ll}" format.name$ *        %$
	    }
	  if$          %$
	  nameptr #1 + 'nameptr :=
	  namesleft #1 - 'namesleft :=
	}
      while$             %$
    }
  if$                    %$
}

FUNCTION {format.names.lastfirst}
{ 's :=
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
  #1 'nameptr :=               % nameptr = 1;
    % WHILE
    { namesleft #0 > }
    { nameptr #1 =
        { s nameptr "{vv~}{ll}{, jj}{, ff}" format.name$                %$
        }
%% 10 Oct 2004 / Lars Borin
%        { comma * 
        {  s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=           %$
          nameptr numnames = 
            % final name
            { t "others" =
                { etal * 
                }
%% 10 Oct 2004 / Lars Borin
                { " and " * t * 
%                { " \& " * t * 
                }
              if$                  %$
            }
            % names both precede and follow this name
            { comma * space * t * 
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=          % nameptr += 1;
      namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$                     %$
}

FUNCTION {format.names.firstfirst}
{ 's :=
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
  #1 'nameptr :=               % nameptr = 1;
    % WHILE
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=                   %$
      nameptr #1 =
        't
        { nameptr numnames =
            % final name
%% 10 Oct 2004 / Lars Borin
%            { numnames #2 >
%                { comma * 
%                }
%                'skip$                  %$
%              if$                  %$
             { t "others" =
                { etal * 
                }
%                { " \& " * t * 
                { " and " * t * 
                }
              if$                  %$
            }
            % names both precede and follow this name
            { comma * space * t * 
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=          % nameptr += 1;
      namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$                   %$
}

FUNCTION {make.annotation}
{ annotation empty$       %$
    { ""
    }
    { "\begin{SCannotation}"
      annotation *
      "\end{SCannotation}" *
    }
  if$           %$
}

FUNCTION {make.edition}
{ edition empty$                  %$
    { seriesedition empty$ not series field.or.null title field.or.null = and             %$
        { seriesedition
        }
        { ""
        }
      if$                                    %$
    }
    { edition
    }
  if$                                        %$
}

FUNCTION {make.year.month}
  { year empty$                  %$
      { ""
      }
      { year year.label.tag *
	month empty$                  %$
	  'skip$                  %$
	  { comma * space * month *
          }
	if$                  %$
      }
    if$                                      %$
}

FUNCTION {make.year.nomonth}
{ year empty$                                %$
    { ""
    }
    { year year.label.tag *
    }
  if$                                        %$
}

FUNCTION {make.year.or.oyear.month}
{ oyear empty$                  %$
    { make.year.month
    }
    { year empty$                  %$
        { "oyear without year in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
      oyear year.label.tag *
      month empty$                  %$
        'skip$                  %$
	{ comma * space * month *
        }
      if$                  %$
    }
  if$                    %$
}

FUNCTION {make.leaditem.with.tags}
{ leaditem
  principal-type editor.ptype =
    { editor num.names$ #1 >         %$
	{ "~(eds)" * 
	}
	{ "~(ed.)" * 
	}
      if$                  %$
    }
    'skip$                 %$
  if$                 %$
}

FUNCTION {make.editors.secondary}
{ editor empty$                  %$
    { "" 
    }
    { 
      editor format.names.firstfirst 
      editor num.names$ #1 >         %$
	  { "~(eds)" * 
	  }
	  { "~(ed.)" * 
	  }
      if$                  %$
    }
  if$                                        %$
}

%FUNCTION {make.editors.secondary}
%{ editor empty$                  %$
%    { "" 
%    }
%    { output.state after.sentence = 
%      output.state after.block = or
%        { "E"
%        }
%        { "e"
%        }
%      if$                  %$
%      "dited by " * editor format.names.firstfirst * 
%    }
%  if$                                        %$
%}

FUNCTION {make.bookauthors.secondary}
{ bookauthor empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "B"
        }
        { "b"
        }
      if$                  %$
      "y " * bookauthor format.names.firstfirst * 
    }
  if$                  %$
}

FUNCTION {make.translators}
{ translator empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "T"
        }
        { "t"
        }
      if$                  %$
      "ranslated " *
      flanguage empty$                  %$
        'skip$                  %$
        { "from the " * flanguage * space *
        }
      if$                  %$
      "by " * translator format.names.firstfirst *
    }
  if$                  %$
}

FUNCTION {make.illustrators}
{ illustrator empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "I"
        }
        { "i"
        }
      if$                  %$
      "llustrated by " * illustrator format.names.firstfirst *
    }
  if$                  %$
}

FUNCTION {make.title.ital}
{ title field.or.null "t" change.case$ italicize
}

FUNCTION {make.booktitle.ital}
{ 
%  booktitle field.or.null italicize
   booktitle field.or.null "t" change.case$ italicize
}

FUNCTION {make.as.ftitle.ital}
{ ftitle empty$                  %$
    { ""
    }
    { "as " ftitle italicize *
    }
  if$                  %$
}

FUNCTION {make.title.inquotes}  
{ title empty$               %$
    { "" 
    }
%% change.case$ added //LB 2006-11-12:
    { 
%%      "\Wrapquotes{" title "t" change.case$ * "}" * 
      title "t" change.case$
    }   
  if$                                  %$
}

FUNCTION {make.pages}
{ pages empty$               %$
    { "" 
    }
    { pages format.n.dashify
    }
  if$                                     %$
}

FUNCTION {make.vol.series.num.month.pages}
{ volume empty$                   %$
    { series empty$                   %$
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
                    % none of VSNMP
		    { space 'u :=
                      ""
		    }
                    % P
		    { comma 'u :=
                      multipage.p
                        { "pp." pages format.n.dashify
			}
                        { "p." pages
			}
                      if$                   %$
                      tie.or.space.connect
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
                    % M
		    { comma 'u :=
                      month
		    }
                    % MP
		    { comma 'u :=
                      month comma * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
                    % N
		    { comma 'u :=
                      "no." number tie.or.space.connect
		    }
		    % NP
		    { comma 'u :=
                      "no." number colon * make.pages * tie.or.space.connect
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % NM
		    { comma 'u :=
                      "no." number tie.or.space.connect
                      space * month parenthesize *
		    }
		    % NMP
		    { comma 'u :=
                      "no." number tie.or.space.connect
                      space * month parenthesize *
                      colon * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % S
		    { 
		    }
		    % SP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % SM
		    {
		    }
		    % SMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % SN
		    {
		    }
		    % SNP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % SNP
		    {
		    }
		    % SNMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
      if$                   %$
    }
    { series empty$                   %$
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % V
		    { comma 'u :=
                      "vol." volume tie.or.space.connect
		    }
		    % VP (modified 10 Oct 2004; Lars Borin
		    { space 'u :=
                      volume colon * space * make.pages *
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VM
		    { comma 'u :=
                      "vol." volume tie.or.space.connect
                      space * month parenthesize *
		    }
		    % VMP
		    { space 'u :=
                      volume space *
                      month parenthesize * colon * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VN
		    { space 'u :=
                     volume ", no." number tie.or.space.connect *
		    }
		    % VNP
		    { space 'u :=
                      volume space * 
                      number parenthesize * colon * space * make.pages *
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VNM
		    { space 'u :=
                      volume ", no." number tie.or.space.connect *
                      space * month parenthesize *
		    }
		    % VNMP
		    { space 'u :=
                      volume space * number parenthesize * colon * space *
                      make.pages * space * month parenthesize *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VS
		    { 
		    }
		    % VSP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VSM
		    {
		    }
		    % VSMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VSN
		    {
		    }
		    % VSNP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VSNM
		    {
		    }
		    % VSNMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
      if$                   %$
    }
  if$                                            %$
}

FUNCTION {make.crossref}
{ "\citeNP{" crossref * "}" *
}

FUNCTION {output.series.number}
{ series empty$                   %$
    { number empty$                   %$
        { ""
        }
        { "Can't use `number' without `series' in " cite$ * warning$
          "" 
        }
      if$                   %$
    }
    { number empty$                   %$
	{ series
          seriesedition empty$                   %$
            'skip$                   %$
            { comma output
              new.block
              seriesedition
            }
          if$                   %$
	}
	{ series space * 
          "no." *
	  number tie.or.space.connect    
	 "number and seriesedition" seriesedition either.or.check
	}
      if$                   %$
    }
  if$                                         %$
  comma output
}

FUNCTION {output.volume.series}
{ volume empty$                   %$
    { ""
    }
    { "Volume" volume tie.or.space.connect
      series empty$                   %$
        'skip$                   %$
        { " of " * series italicize * 
          seriesedition empty$                   %$
            'skip$                   %$
            { comma output
              new.block
              seriesedition
            }
          if$                   %$
        }
      if$                   %$
      "volume and number" number either.or.check
    }
  if$                   %$
  comma output
}

FUNCTION {make.chapter.of}
{ chapter empty$        %$
    { ""
    }
    { type empty$        %$
        { "Chapter" 
        }
        { type "t" change.case$         %$
        }
      if$        %$
      chapter tie.or.space.connect
      " of " *
    }
  if$                   %$
}

FUNCTION {make.chapter}
{ chapter empty$                   %$
    { ""
    }
    { type empty$                   %$
        { "Chapter"
        }
        { type "t" change.case$                   %$
        }
      if$                   %$
      chapter tie.or.space.connect
    }
  if$                   %$
}

FUNCTION {make.number.tr}
{ type empty$                   %$
    { "Technical Report" 
    }
    { type "t" change.case$                    %$
    }
  if$                   %$
  number empty$                   %$
    'skip$                   %$
    { number tie.or.space.connect 
    }
  if$                   %$
}

FUNCTION {set.principal-field.principal-type}
{   type$ "book" =               %$
    type$ "inbook" =               %$
  or
    { start.a.q 
      author.q
      editor.q
      blank.q 
      key.q 
      "author, editor, or key for entry type " type$ * check.q          %$
    }
    { type$ "proceedings" =                   %$
        { start.a.q
          blank.q
          editor.q
          organization.q
          key.q
          "editor, organization, or key for entry type " type$ * check.q    %$
        }
        { type$ "manual" =                   %$
            { start.a.q
              author.q
              blank.q
              organization.q
              key.q
              "author, organization, or key for entry type " type$ * check.q   %$
            }
            % for all other entry types
            { start.a.q
              author.q
              blank.q
              blank.q
              key.q
              "author or key for entry type " type$ * check.q       %$
            }
          if$                   %$
        }
      if$                   %$
    }
  if$                   %$
  'principal-field :=
  j 'principal-type :=
}

FUNCTION {key.special.p}
{       type$ "manual" =             %$
	type$ "proceedings" =        %$
      or
      principal-type organization.ptype =
    and
    key empty$ not                 %$
  and
}

FUNCTION {make.leaditem}
{ key.special.p
    % is \field{key} all-caps?
    { key duplicate$ "u" change.case$ =
        % if so, key is assumed to be an acronym FIX; should I warn what we're doing?
        { key " (" * organization * ")" *
        }
        % if not, key is assumed to be an initial prefix (abbreviation) of organization
        % for use only in the label
        { organization
        }
      if$                   %$
    }
    { principal-field
	principal-type author.ptype =
	principal-type editor.ptype =
      or
	{ format.names.lastfirst
	}
	% organization, key, or emergency ptype
	'skip$               %$
      if$                   %$
    }
  if$              %$
}

FUNCTION {make.label.from.principal-field}
{ principal-field
    principal-type author.ptype =
    principal-type editor.ptype =
  or
    { format.names.for.label
    }
    % organization, key, or emergency
    'skip$               %$
  if$                   %$
}

FUNCTION {make.label}
{ key.special.p
    { key
    }
    { make.label.from.principal-field
    }
  if$               %$
}


FUNCTION {length}
{ 'u :=
  #0 'len :=
  % WHILE
  { u "" = not }
    { len #1 + 'len :=
      u #2 global.max$ substring$ 'u :=
    }
  while$         %$
  len
}

FUNCTION {head}
{ 'w :=
  w #1 #1 substring$      %$
  duplicate$ "{" =       %$
    { w #2 #1 substring$ "\" =      %$
        { pop$       %$
          w #1 text.prefix$     %$
        }
        'skip$   %$
      if$       %$
    }
    'skip$      %$
  if$        %$
}

FUNCTION {behead}
{ 'u :=
    u
    u head length #1 +
    global.max$            %$
  substring$      %$
}

FUNCTION {behead.t}
{ t behead 't :=
}

FUNCTION {format.dehyphen}
{ 't :=
  ""
  % WHILE
  { t "" = not }
    { t head
      duplicate$ hyphen =         %$
        { pop$                    %$
        }
        { *
        }
      if$                %$
      behead.t
    }
  while$                                  %$
}


FUNCTION {format.dehyphen.dewhitespace}
{ 't :=
  ""
  % WHILE
  { t "" = not }
    { t head
      duplicate$                  %$
        duplicate$ hyphen =       %$
        swap$ empty$
      or
        { pop$                    %$
        }
        { *
        }
      if$                %$
      behead.t
    }
  while$                                  %$
}

FUNCTION {format.names.for.sort}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=                  %$
  numnames 'namesleft :=
  % WHILE
  { namesleft #0 > }
    {
      % NOTE: order or name-parts ought to follow that used for leaditem
      % word-by-word alphabetization:
      % letter-by-letter alphabetization, no attention to initials:

      % letter-by-letter alphabetization, with first initials exception:

%     s nameptr "{vv{}}{ll{}}{  jj{}}" format.name$         %$
      s nameptr "{ll{}}{  jj{}}" format.name$         %$

      % Each first-name token of the form of an initial ("L.") will be followed by a
      % space but other spaces will be removed.

      % Algorithm: step through looking for space, which terminates name tokens,
      % adding non-spaces to an accumulator on the stack as we go.
      % When we find a space, look at the accumulator (a whole name token).
      % If it's length is 2 and 2d char is a period, we've got an initial, so
      % add the space to the accumulator.  If not, throw away the space
      % and step on looking for another name.
      
      % FIX: would it be simpler to replace periods with spaces?
      %      would a period ever appear in a first-name when not an initial?
      %      Rev.?  Col.?  These should be alphabetized as spelled out, prob.
      %      but need to check \manual


      s nameptr "{ff{ } }" format.name$ 't :=      %$
      % t is "F1 F2 F3 ... FN " or empty


      t empty$       %$
        'skip$       %$
        { delimiter.name-part *
          ""        % accumulator
          % WHILE
          { t "" = not }
            { t head
              duplicate$ empty$
                % last char will always be a space
                % accumulator contains whole name token
                { pop$       %$  throw space away for now; top of stack is now accumulator
                  duplicate$ %$
                    duplicate$ text.length$ #2 =        %    2 chars long
                    swap$ behead head period =          %$   2d char is period    
                  and
                    % name token in accumulator is an initial, so add a space to it
                    { space *
                    }
                    % name token in accumulator is not an initial
                    'skip$      %$
                  if$        %$
                  % in either case, concatenate the accumulator the name on the
                  % stack and initialize it again
                  * ""
                }
                % accumulator contains partial name token
                % add t's head (not a space) to accumulator
                { *
                }
              if$         %$
              behead.t
            }
          while$            %$
          % we always end up with an empty string on the stack
          pop$     %$
        }
      if$      %$

      format.dehyphen
      't :=
      % t now contains one name of a namelist
      nameptr #1 =      
        { t
        }
        { delimiter.name *
	    nameptr numnames =
            t "others" =
          and
            { "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" *
            }
            { t *
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$                  %$
}

FUNCTION {make.principal-field.for.sort}  % FIX: note: leaditem must already be set
{   principal-type author.ptype =
    principal-type editor.ptype =
  or
    { principal-field format.names.for.sort
    }
    { principal-type emergency.ptype =
        { principal-field
        }
        % organization.ptype, key.ptype, including both key.special cases
        % leaditem is the same as principal-field except in the key.special
        % cases, when we do want the leaditem not the principal-field
	{ leaditem	  
	  % letter-by-letter alphabetization:
          format.dehyphen.dewhitespace
        }
      if$           %$
    }
  if$            %$
}

FUNCTION {begin.entry}
{ output.begin
  output.bibitem
}

FUNCTION {finish.entry}
{ add.period$                      %$
  output.end
  newline$                         %$
  make.annotation write$           %$
}

FUNCTION {article}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth "year" check.empty * space output
  new.block
%% Maybe fix quotes? 
%% Title should be lowercased, anyway //LB 2006-11-12
  make.title.inquotes "title" check.empty space output
  new.block
  crossref empty$                              %$
    { journal italicize "journal" check.empty space output
      series empty$                              %$
        'skip$                              %$
        { "Achicago can not yet handle nonempty series! in " cite$ * warning$
        }
      if$                              %$
      volume empty$ number empty$ month empty$ pages empty$ and and and
        { "empty volume, number, month, and pages in " cite$ * warning$
        }
        'skip$                              %$
      if$                              %$
      make.vol.series.num.month.pages u output
    }
    { "In " make.crossref * space output
      make.pages "pages" check.empty comma output
    }
  if$                              %$
  new.block
  note space output
  finish.entry
}
FUNCTION {book}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.or.oyear.month "year" check.empty * space output
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  crossref empty$                              %$
    { volume empty$                              %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                              %$
      editor empty$ author empty$ or
        'skip$                              %$
        { new.block
          make.editors.secondary comma output
        }
      if$                  %$
      new.block
      make.translators comma output
      new.block
      make.illustrators comma output
      new.block
      oyear empty$                              %$
        { address comma output
          publisher "publisher" check.empty colon output
        }
        { oaddress comma output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address field.or.null comma output
          publisher "publisher" check.empty
          address empty$                              %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year "year" check.empty comma output          
        }
      if$                              %$
    }
    { volume empty$                              %$
        { "In "
        }
        { "Volume" volume tie.or.space.connect
          " of " *
        }
      if$                      %$
      make.crossref * comma output
    }
  if$                              %$
  new.block
  yearcomp empty$                              %$
    'skip$                              %$
    { "Composed in " yearcomp *
      comma output
      new.block
    }
  if$                              %$
  fyear empty$
    'skip$
    { "First published "
      translator empty$ flanguage empty$ not and
        { "in " * flanguage * space *
        }
        'skip$
      if$
      make.as.ftitle.ital * space output
      faddress empty$ fpublisher empty$ not and
        { "by "
        }
        { "in "
        }
      if$                  %$
      space output
      faddress space output
      fpublisher
      faddress empty$                  %$
        { space
        }
        { colon
        }
      if$                  %$
      output
      fyear
      faddress empty$ fpublisher empty$ and
        { space
        }
        { comma
        }
      if$ output                  %$
      new.block
    }
  if$                                        %$
  note comma output
  finish.entry
}

FUNCTION {inbook}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.or.oyear.month "year" check.empty * space output
  new.block
  crossref empty$            %$
    { make.chapter.of
      duplicate$ 'u :=              %$
%      duplicate$ empty$
%        { pop$                  %$
%          pages empty$                  %$
%            { "empty chapter, type, and pages in " cite$ * warning$ 
%              "In "
%               ""
%            }
%            { "Pages " make.pages * " in " *
%            }
%          if$                  %$
%        }
%        'skip$                  %$
%      if$                  %$
      period output
      new.block
      make.editors.secondary space output
      comma output
      make.title.ital "title" check.empty comma output
%      make.bookauthors.secondary comma output
%      make.editors.secondary comma output
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
      u empty$                  %$
        'skip$                  %$
        { make.pages comma output
        }
      if$                  %$
      new.block
      make.translators comma output
      new.block
      make.illustrators comma output
      new.block
      oyear empty$                  %$
        { address comma output
          publisher "publisher" check.empty colon output
        }
        { oaddress comma output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address field.or.null comma output
          publisher "publisher" check.empty
          address empty$                  %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year "year" check.empty comma output          
        }
      if$                  %$
    }
    % crossref not empty
    { "In " make.crossref * comma output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note comma output
  finish.entry
}

FUNCTION {incollection}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.or.oyear.month "year" check.empty * space output
  new.block
%% Here, too //LB 2006-11-12
  make.title.inquotes "title" check.empty period output
  new.block
  crossref empty$                  %$
%    { make.chapter.of duplicate$ empty$
%        { pop$                  %$
%          "In "
%           ""
%        }
%        'skip$                        %$
%      if$                  %$
     {
      make.editors.secondary space output
      make.booktitle.ital "booktitle" check.empty comma output
%      make.bookauthors.secondary comma output
%      make.editors.secondary comma output
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
      make.pages comma output
      chapter empty$ type empty$ and pages empty$ and                  %$
        { "empty chapter, type, and pages in " cite$ * warning$
        }
        'skip$                          %$
      if$                  %$
      new.block
      make.translators space output
      new.block
      make.illustrators space output
      new.block
      oyear empty$                  %$
        { address space output
          publisher "publisher" check.empty colon output
        }
        { oaddress space output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address comma output
          publisher "publisher" check.empty
          address empty$                  %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year comma output          
        }
      if$                  %$
    }
    % crossref not empty
    { new.block
      "In " make.crossref * space output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note space output
  finish.entry
}

FUNCTION {format.thesis}
{ 'v :=
  begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth "year" check.empty * space output
  new.block
%% and here //LB 2066-11-12
  make.title.inquotes "title" check.empty space output
  new.block
  v "type" check.empty space output
  school "school" check.empty comma output
  address comma output
  new.block
  note space output
  finish.entry
}

FUNCTION {thesis}
{ type field.or.null format.thesis 
}

FUNCTION{mastersthesis}
{ type empty$               %$
    { "Master's thesis"
    }
    { type
    }
  if$               %$
  format.thesis
}

FUNCTION {minorthesis}
{ mastersthesis
}

FUNCTION {phdthesis}
{ type empty$               %$
    { "Ph.D.~diss."
    }
    { type
    }
  if$               %$
  format.thesis
}

FUNCTION {majorthesis}
{ phdthesis
}

FUNCTION {manual}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth * space output
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  address space output
  organization colon output
  new.block
  note space output
  finish.entry
}

FUNCTION {booklet}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth * space output
  new.block
  make.title.inquotes "title" check.empty comma output
  new.block
  howpublished space output
  address comma output
  new.block
  note space output
  finish.entry
}

FUNCTION {inproceedings}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth "year" check.empty * space output
  new.block
%% and here //LB 2006-11-12
  make.title.inquotes "title" check.empty space output
  new.block
  crossref empty$                  %$
    { make.editors.secondary space output
      make.booktitle.ital "booktitle" check.empty comma output 
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
      make.pages comma output
      new.block
      organization space output
      address comma output
      publisher colon output
%      make.pages comma output
    }
    { "In " make.crossref * space output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note space output
  finish.entry
}

FUNCTION {conference} 
{ inproceedings
}

FUNCTION {proceedings}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth "year" check.empty * space output
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  volume empty$               %$
    { output.series.number
    }
    { output.volume.series
    }
  if$               %$
  new.block
  organization space output
  address comma output
  publisher colon output
  new.block
  note comma output
  finish.entry
}

FUNCTION {misc}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth * space output
  new.block
  title space output
  new.block
  howpublished comma output
  new.block
  note space output
  finish.entry
}

FUNCTION {techreport}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth "year" check.empty * space output
  new.block
  make.title.inquotes "title" check.empty comma output
  new.block
  make.number.tr comma output
  institution "institution" check.empty comma output
  address comma output
  new.block
  note comma output
  finish.entry
}

FUNCTION {unpublished}
{ begin.entry
  make.leaditem.with.tags space *
  make.year.nomonth * space output
  new.block
  make.title.inquotes "title" check.empty space output
  new.block
  note "note" check.empty space output
  finish.entry
}

FUNCTION {default.type} 
{ misc }

FUNCTION {chop.word}
{ 't :=
  'len :=
  t #1 len substring$ =               %$
    { t len #1 + global.max$ substring$
    }
    { t
    }
  if$               %$
}

%% ===================================================================
%% Sorting stuff for labelling same author/same year works in citation order
%% Lars Borin 13 Oct 2004 
    %
    % convert integer to string, assume that integer < 1000
    % from apacite.bst by Erik Meijer <Meijer@rulfsw.LeidenUniv.nl>
    %
FUNCTION {conv.int.to.str}
{ duplicate$ #10 <
    { "00" swap$ int.to.str$ * }
    { duplicate$ #100 <
        { "0" swap$ int.to.str$ * }
        { int.to.str$ }
      if$
    }
  if$
}

FUNCTION {init.citation.order.sort}
{ #0 'citation.no :=
}

FUNCTION {bump.citation.order.and.stringify}
{ citation.no #1 + duplicate$ 'citation.no := conv.int.to.str
}

FUNCTION {sortkey<-label+year+principal+citation.no}
{ label
  delimiter.sub-sortkey *
  year.label *
  delimiter.sub-sortkey *
  make.principal-field.for.sort *
  delimiter.sub-sortkey *
  bump.citation.order.and.stringify *
  format.sortify.clip
  'sort.key$ :=                  %$
}

%% ====================================================================

FUNCTION {make.title.for.sort}
{ title field.or.null
  't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  format.dehyphen.dewhitespace
}

FUNCTION {presort}
{ set.principal-field.principal-type

  make.leaditem
  'leaditem :=

  make.label
  'label :=

  oyear empty$                   %$
    { year
    }
    { oyear
    }
  if$                   %$
  field.or.null purify$ #-1 #4 substring$
  'year.label :=
}

FUNCTION {sortkey<-label+year+principal+title}
{ label
  delimiter.sub-sortkey *
  year.label *
  delimiter.sub-sortkey *
  make.principal-field.for.sort *
  delimiter.sub-sortkey *
  make.title.for.sort *
  format.sortify.clip
  'sort.key$ :=                  %$
}

FUNCTION {sortkey<-principal+year+year-tag}
{ make.principal-field.for.sort
  delimiter.sub-sortkey *
  year.label *
  year.label.tag *
  format.sortify.clip
  'sort.key$ :=                  %$
}

FUNCTION {presort.&.sortkey<-label+year+principal+title}
{ presort
  sortkey<-label+year+principal+title
}

%% ========================================
%% Lars Borin 13 Oct 2004 -- citation order sorting
%%
FUNCTION {presort.&.sortkey<-label+year+principal+citation.no}
{ presort
  sortkey<-label+year+principal+citation.no
}
%% ========================================

FUNCTION {initialize.sorting-gvars}
{ unidentified 'last.leaditem :=
  unidentified 'last.label.and.year :=
  "" 'following.year.label.tag :=
  #0 'last.year.tag.num :=
}

FUNCTION {forward.pass.wrap.dupe.leaditems}
{ leaditem
  duplicate$ last.leaditem =                  %$
    % we add the brace pair at the end because this forces add.period$ to add a  %$
    % period after it.  FIX: if we ever want \SCdup to actually print its
    % argument, we must get it to print its argument minus any final period.
    { "\SCduplicate{" swap$ * "{}}" * 'leaditem :=                  %$
    }
    { 'last.leaditem :=
    }
  if$                  %$
}

FUNCTION {forward.pass.add.bcds}
{ label year.label * format.clip
  duplicate$ last.label.and.year =                  %$
    % same as previous entry
    { pop$                  %$
      last.year.tag.num #1 + 'last.year.tag.num :=
      last.year.tag.num int.to.chr$ 'year.label.tag :=                  %$
    }
    % different from previous entry
    { "a" chr.to.int$ 'last.year.tag.num :=                  %$
      "" 'year.label.tag :=
      'last.label.and.year := 
    }
  if$                  %$
}

FUNCTION {reverse.pass.add.as}
{ following.year.label.tag "b" =
    { "a" 'year.label.tag := 
    }
    'skip$                  %$
  if$                  %$
  year.label.tag 'following.year.label.tag :=
}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$                  %$
    { preamble$ write$ newline$                  %$
    }
  if$                  %$
  "\begin{thebibliography}{}" write$ newline$
}

FUNCTION {end.bib}
{ newline$                  %$
  "\end{thebibliography}" write$ newline$
}

%%
%%  Main program
%%

READ

EXECUTE {init.scalars}

% Lars Borin 13 Oct 2004 -- sorting same year by citation order 
% instead of title
% ITERATE {presort.&.sortkey<-label+year+principal+title}
EXECUTE {init.citation.order.sort}
ITERATE {presort.&.sortkey<-label+year+principal+citation.no}
SORT 

EXECUTE {initialize.sorting-gvars}

ITERATE {forward.pass.add.bcds}
REVERSE {reverse.pass.add.as}

ITERATE{sortkey<-principal+year+year-tag}
SORT 

EXECUTE {initialize.sorting-gvars}
ITERATE {forward.pass.wrap.dupe.leaditems}


EXECUTE {begin.bib}
ITERATE {call.type$}                  %$
EXECUTE {end.bib}
