local strings = strings or {}
if tex then local print = tex.print end
-- Greek monotonico
--
strings.greek = {
  abstract          = "Περίληψη",
  partname          = "Mέρος",
  chaptername       = "Κεφάλαιο",
  sectionname       = "Tμήμα",
  subsectionname    = "υποδιαίρεση",
  subsubsectionname = "ανθυποενότητα",
  paragraphname     = "παράγραφος",
  appendixname      = "Παράρτημα", 
  bibliographyname  = "Βιβλιογραφία",
  indexname         = "Ευρετήριο",
  glossaryname      = "Γλωσσάρι",
  tablename         = "Πίνακας",
  figurename        = "Σχήμα", 
  pagename          = "Σελίδα",
  seename           = "βλέπε",
  equationname      = "εξίσωση",
  contentsname      = "Περιεχόμενα",
  prefacename       = "Πρόλογος",
  listfigurename    = "Κατάλογος σχημάτων",
  listtablename     = "Κατάλογος πινάκων",
  alsoname          = "βλέπε επίσης",
  proofname         = "Απόδειξη",
  refname           = "Αναφορές",
  prefacename       = "Πρόλογος",
  leftname          = "Aristera",
  bindingcorrectionname = "δεσμευτική διόρθωση",
  greekname         = "ελληνικά",
  months = {
    "Ιανουάριος",
    "Φεβρουάριος",
    "Μάρτιος",
    "Απρίλιος",
    "Μάιος",
    "Ιούνιος",  
    "Ιούλιος",
    "Αύγουστος",
    "Σεπτέμβριος",
    "Οκτώβριος",
    "Νοέμβριος",
    "Δεκέμβριος"
  },
  monthsabr = {
    "Ιαν",
    "Φεβ",
     "Μαρ",
     "Απρ",
     "Μαΐ",
     "Ιουν",
     "Ιουλ",
     "Αυγ",
     "Σεπ",
     "Οκτ",
     "Νοε",
     "Δεκ"
  },   
  days = {
    "Κυριακή",
    "Δευτέρα",
    "Τρίτη",
    "Τετάρτη",
    "Πέμπτη",
    "Παρασκευή",
    "Σάββατο"
  },
  firstday = "monday"
}

local patientVisit= {
    patientClass = "CON",
    assignedPatientLocation = {
        pointOfCare = "8152879"
    },
    visitNumber = {
        idNumber = 16164813
    }
 }

function inspect_table (tab, offset)
    offset = offset or "\\mbox{~~}"
    for k, v in pairs (tab) do
        local newoffset = offset .. offset
        if type(v) == "table" then
           print(offset..k .. " = \\{\\par ")
           inspect_table(v, newoffset)
           print(offset.."\\}\\par")
        else
         if k~="data" then print(offset..k.." =  "..tostring(v),"\\par") 
           else
              print(offset.."k = char data ")
           end
       end
    end
end

inspect_table(patientVisit)