local phd_module = {
    name          = "polish",
    version       = 1.0,
    date          = "2014/11/11",
    description   = "Polish language i18n translations",
    author        = "Y Lazarides",
    copyright     = "Y Lazarides",
    license       = "CC0"
}

local strings = strings or {}
      strings.polish = {}
      
strings.polish.init = {
  hyphennames = "polish", 
  hyphenmins = {2,3},
  frenchspacing = true,
  fontsetup = true
  }

strings.polish = {
  abstract          = "Przedmowa",
  partname          = "Część",
  chaptername       = "Rozdział",
  sectionname       = "",
  subsectionname    = "",
  subsubsectionname = "",
  paragraphname     = "",
  appendixname      = "Dodatek", 
  bibliographyname  = "",
  indexname         = "Indeks",
  glossaryname      = "Glossary",  -- possibly wrong
  tablename         = "Tabela",
  figurename        = "Rysunek", 
  pagename          = "Strona",
  seename           = "",
  equationname      = "",
  contentsname      = "Spis treści",
  prefacename       = "",
  listfigurename    = "Spis rysunków",
  listtablename     = "Dowód",
  alsoname          = "",
  proofname         = "Dowód",
  refname           = "Literatura",
  leftname          = "",
  rightname         = "",
  bindingcorrectionname = "",
  name              = "Polish",
  months              = {
    "stycznia",
    "lutego",
    "marca",
    "kwietnia",
    "maja",
    "czerwca",
    "lipca",
    "sierpnia",
    "września",
    "października",
    "listopada",
    "grudnia"
    }
  }
  
  return strings