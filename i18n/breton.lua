local phd_module = {
    name          = "breton",
    version       = 1.0,
    date          = "2014/11/11",
    description   = "Breton language i18n translations",
    author        = "Y Lazarides",
    copyright     = "Y Lazarides",
    license       = "CC0"
}

local strings = strings or {}

strings.breton = {
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
  name              = "breton",
  months              = { 
   "datebreton"
  },
  datebreton = [[
  \def\datebreton{%
   \def\today{\ifnum\day=1\relax 1\/\textsuperscript{añ}\else
    \number\day\fi \space a\space viz\space\ifcase\month\or
    Genver\or C'hwevrer\or Meurzh\or Ebrel\or Mae\or Mezheven\or
    Gouere\or Eost\or Gwengolo\or Here\or Du\or Kerzu\fi
    \space\number\year}}
    ]]
 } 
 
 -- print(strings.breton.datebreton)
 return strings