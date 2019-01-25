local strings = strings or {}

 strings.occidanday = function (num) 
  if num ==1 then s = " 1èr " 
    else
      s = "primièr "..num 
  end
    
  return s -- formatted string
end 

 strings.occidan = {
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
  name              = "occitan",
  months              = { 
      "de~genièr",
      "de~febrièr",
      "de~març",
      "d'abril",
      "de~mai",
      "de~junh",
      "de~julhet",
      "d'agost",
      "de~setembre",
      "d'octobre",
      "de~novembre",
      "de~decembre"
  },
  --day = strings.occidanday, -- callback?
  --dateformat = 'DD MM YY'
 }
 
 
 
 -- print(strings.occidan.day(1))
 -- print(strings.occidan.months[1] )

return strings