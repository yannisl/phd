%% Driver class
%% 


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{phd}[2010/04/27 driver class for package phd.sty]

% layout options:




\DeclareOption{article}{\def\defaultclass@cx{article}}
\DeclareOption{book}{\def\defaultclass@cx{book}}
\DeclareOption{memoir}{\def\defaultclass@cx{memoir}}
\DeclareOption{report}{%
   \def\defaultclass@cx{report}
   \newenvironment{frontmatter}{}{}
   \def\mainmatter{}
   \let\sidenote\footnote
}

% 
% Any unnown options we pass to the default class
% with the \cs{DeclareOption*}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\defaultclass@cx}}

\ProcessOptions*

\LoadClass{\defaultclass@cx}




% Load additional macros and modifications for "article.cls"
\RequirePackage{pgfkeys}

\newcommand\cxsets{\pgfqkeys{/phds }}
\cxsets{document class/.store in =\defaultclass@cx}
\cxsets{document class=book}



\IfFileExists{phd.sty}{}{\ClassError{phd}{The complimentary package file "phd.sty" is required}{
The complimentary style file "phd.sty" is required\MessageBreak
You need to install file "phd.sty" in your system.\MessageBreak
The file can be downloaded from https://github.com/yannisl/phd
}}

\RequirePackage{phd}

\endinput
%%
%% History:
%% 2010.04.27 - support for the "Stochastic Systems" (ssy) added;
%% 2009.08.13 - options [numbers,sort&compress] from natbib package removed
%% 2009.05.21 - added new option "bjps"
%% 2008.01.09 - added new option "coll"
%% 2007.12.10 - added new option "aihp"
%% 2007.08.22 - aoas: default value for natbib set to authoryear 
%% End of file `imsart.cls'.
