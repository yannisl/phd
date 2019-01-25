local strings = strings or {}

strings.bulgarian = {
  abstract          = "Абстракт",
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
  pagename          = "Стр.",
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
  name              = "bulgarian",
  months              = { 
    "datebulgarian"
  },
  datebulgarian = [[
  \def\datebulgarian{%
   \def\today{\number\day~\ifcase\month\or
       януари\or
       февруари\or
       март\or
       април\or
       май\or
       юни\or
       юли\or
       август\or
       септември\or
       октомври\or
       ноември\or
       декември\fi%
       \ \number\year~г.}%
    \def\month@Roman{\expandafter\@Roman\month}%
    \def\todayRoman{\number\day.\,\month@Roman.\,\number\year~г.}%
    } ]]
  
 }
 
return strings 