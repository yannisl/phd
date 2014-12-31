local phd_modules  = phd_modules or {}

local z = io.open("i18n.el.territories") -- loads the json file

phd_modules = phd_modules or { 
  albanian = {
    name          = "albanian",
    version       = 1.0,
    date          = "2014/11/13",
    description   = "Albanian language i18n translations",
    author        = "Y Lazarides",
    copyright     = "Y Lazarides",
    license       = "CC0"
  }
}

local m = m or {}

m.albanian = {
  abstract          = "Përmbledhja",
  partname          = "",
  chaptername       = "Kapitulli",
  sectionname       = "",
  subsectionname    = "",
  subsubsectionname = "",
  paragraphname     = "",
  appendixname      = "Shtesa", 
  bibliographyname  = "Bibliografia",
  indexname         = "Indeksi",
  glossaryname      = "Përhasja e Fjalëve",
  tablename         = "Tabela",
  figurename        = "Figura", 
  pagename          = "Faqe",
  seename           = "shiko",
  equationname      = "",
  contentsname      = "Përmbajta",
  prefacename       = "Parathenia",
  listfigurename    = "Figurat",
  listtablename     = "Tabelat",
  alsoname          = "shiko dhe",
  proofname         = "Vërtetim",
  refname           = "Referencat",
  leftname          = "",
  rightname         = "",
  bindingcorrectionname = "",
  albanianname         = "albanian",
  months              = {
    "Janar",
    "Shkurt",
    "Mars",
    "Prill",
    "Maj",
    "Qershor",
    "Korrik",
    "Gusht",
    "Shtator",
    "Tetor",
    "Nëntor",
    "Dhjeto"
  }
}

return m