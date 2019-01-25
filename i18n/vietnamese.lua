 local strings = strings or {}
 
 strings.vietnamese = {
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
  name              = "vietnamese",
  months              = { 
    1,2,3,4,5,6,7,8,9,10,11,12
  },
  datevietnamese      = [[\def\datevietnamese{%
  \def\today{%
    Ngày \number\day\space
    tháng \number\month\space
    năm \number\year}%
  }]]
  }
  
return strings  

--print(strings.vietnamese.datevietnamese)
  