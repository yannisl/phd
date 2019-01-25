local strings = strings or {}

-- Hungarian date formatting goes from the generic to the specific
 -- year.month.day time
 -- Date separated by hyphen also used.
 -- 
 strings.magyar = {
  abstract          = "Kivonat",
  partname          = "",
  chaptername       = "fejezet", -- check caps
  sectionname       = "",
  subsectionname    = "",
  subsubsectionname = "",
  paragraphname     = "",
  appendixname      = "Függelék", 
  bibliographyname  = "Irodalomjegyzék",
  indexname         = "Tárgymutató",
  glossaryname      = "Szójegyzék",
  tablename         = "táblázat",
  figurename        = "ábra", 
  pagename          = "oldal",
  seename           = "lásd",
  equationname      = "",
  contentsname      = "Tartalomjegyzék",
  prefacename       = "Előszó",
  listfigurename    = "Ábrák jegyzéke",
  listtablename     = "Táblázatok jegyzéke",
  alsoname          = "lásd még",
  proofname         = "Bizonyítás",
  refname           = "Hivatkozások",
  leftname          = "",
  rightname         = "",
  bindingcorrectionname = "",
  name              = "magyar",
  months              = { 
    "január",
    "február",
    "március",
    "április",
    "május",
    "június",
    "július",
    "augusztus",
    "szeptember",
    "október",
    "november",
    "december"
  },
  day = { 
    "1-jén", "2-án", "3-án", "4-én", "5-én",
    "6-án", "7-én", "8-án", "9-én", "10-én",
    "11-én", "12-én", "13-án", "14-én", "15-én",
    "16-án", "17-én", "18-án", "19-én", "20-án",
    "21-én", "22-én", "23-án", "24-én", "25-én",
    "26-án", "27-én", "28-án", "29-én", "30-án",
    "31-én"}
  }
  
  return strings