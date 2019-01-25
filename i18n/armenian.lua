
local phd_module = phd_module or {
  armenian = {
    name          = "armenian",
    version       = 0.5,
    date          = "2014/11/11",
    description   = "Armenian language i18n translations",
    author        = "Y Lazarides",
    copyright     = "Y Lazarides",
    license       = "CC0"
  }
}

local strings = strings or {}

--- 
-- @function provides Armenian strings for LaTeX documents
--
strings.armenian = {
  abstract          = "վերացական",
  partname          = "մաս",
  chaptername       = "գլուխ",
  sectionname       = "հատված",
  subsectionname    = "ենթաբաժին",
  subsubsectionname = "subsubsection",
  paragraphname     = "պարբերություն",
  appendixname      = "հավելված", 
  bibliographyname  = "մատենագիտություն",
  indexname         = "ինդեքս",
  glossaryname      = "մասնագիտական տերմինաբանական բառարան",
  tablename         = "սեղան",
  figurename        = "անձ", 
  pagename          = "էջ",
  seename           = "տեսնել անունը",
  equationname      = "հավասարում",
  contentsname      = "բովանդակությունը",
  prefacename       = "նախաբան",
  listfigurename    = "ցուցակ գործիչների",
  listtablename     = "ցուցակ սեղանների",
  alsoname          = "տես նաեւ",
  proofname         = "ապացույց",
  refname           = "հղումները",
  prefacename       = "նախաբան",
  leftname          = "ձախ",
  bindingcorrectionname = "պարտադիր է ուղղում",
  armenianname          = "հայերեն"
}

return strings
