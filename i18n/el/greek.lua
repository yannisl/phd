local strings = strings or {}

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

-- Greek polytonic, similar to modern greek
-- but has some accents and diacritics
-- 
strings.polygreek = {
  abstract          = "Περίληψη",
  partname          = "Mέρος",
  chaptername       = "Κεφάλαιο",
  sectionname       = "Tμήμα",
  subsectionname    = "υποδιαίρεση",
  subsubsectionname = "ανθυποενότητα",
  paragraphname     = "παράγραφος",
  appendixname      = "Παράρτημα", 
  bibliographyname  = "Βιβλιογραφία",
  indexname         = "Εὑρετήριο",
  glossaryname      = "Γλωσσάρι",
  tablename         = "Πίνακας",
  figurename        = "Σχῆμα", 
  pagename          = "Σελίδα",
  seename           = "βλέπε",
  equationname      = "εξίσωση",
  contentsname      = "Περιεχόμενα",
  prefacename       = "Πρόλογος",
  listfigurename    = "Κατάλογος σχημάτων",
  listtablename     = "Κατάλογος πινάκων",
  alsoname          = "βλέπε ἐπίσης",
  proofname         = "Ἀπόδειξη",
  refname           = "Αναφορές",
  prefacename       = "Πρόλογος",
  leftname          = "Aristera",
  bindingcorrectionname = "δεσμευτική διόρθωση",
  greekname         = "ελληνικά"
}


-- Greek polytonic, similar to modern greek
-- but has some accents and diacritics
-- 
strings.ancientgreek = {
  abstract          = "Περίληψη",
  partname          = "Mέρος",
  chaptername       = "Κεφάλαιο",
  sectionname       = "Tμήμα",
  subsectionname    = "υποδιαίρεση",
  subsubsectionname = "ανθυποενότητα",
  paragraphname     = "παράγραφος",
  appendixname      = "Παράρτημα", 
  bibliographyname  = "Βιβλιογραφία",
  indexname         = "Εὑρετήριο",
  glossaryname      = "Γλωσσάρι",
  tablename         = "Πίνακας",
  figurename        = "Σχῆμα", 
  pagename          = "Σελίδα",
  seename           = "βλέπε",
  equationname      = "εξίσωση",
  contentsname      = "Περιεχόμενα",
  prefacename       = "Πρόλογος",
  listfigurename    = "Κατάλογος σχημάτων",
  listtablename     = "Κατάλογος πινάκων",
  alsoname          = "ὃρα ὡσαύτως",
  proofname         = "Ἀπόδειξη",
  refname           = "Αναφορές",
  prefacename       = "Προοίμιον",
  leftname          = "Aristera",
  bindingcorrectionname = "δεσμευτική διόρθωση",
  greekname         = "ελληνικά"
}

return strings