local strings = strings or {}


strings.esperanto = {
  abstract          = "",
  partname          = "",
  chaptername       = "",
  sectionname       = "",
  subsectionname    = "",
  subsubsectionname = "",
  paragraphname     = "",
  appendixname      = "", 
  bibliographyname  = "",
  indexname         = "",
  glossaryname      = "",
  tablename         = "",
  figurename        = "", 
  pagename          = "",
  seename           = "",
  equationname      = "",
  contentsname      = "",
  prefacename       = "",
  listfigurename    = "",
  listtablename     = "",
  alsoname          = "",
  proofname         = "",
  refname           = "",
  leftname          = "",
  rightname         = "",
  bindingcorrectionname = "",
  name              = "esperanto",
  months              = {},
  dateesperanto = [[\def\dateesperanto{%   
   \def\today{\number\day{–a}~de~\ifcase\month\or
    januaro\or februaro\or marto\or aprilo\or majo\or junio\or
    julio\or aŭgusto\or septembro\or oktobro\or novembro\or
    decembro\fi,\space \number\year}%
   \def\hodiau{la \today}%
   \def\hodiaun{la \number\day{–an}~de~\ifcase\month\or
      januaro\or februaro\or marto\or aprilo\or majo\or junio\or
      julio\or aŭgusto\or septembro\or oktobro\or novembro\or
      decembro\fi, \space \number\year}%
    }]]
 }
 
 return strings