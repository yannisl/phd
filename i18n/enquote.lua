-- test file internal enquote
--
delimiters = {
        quotationStart = "«",
        quotationEnd = "»",
        alternateQuotationStart = "\"",
        alternateQuotationEnd = "\""
      }
print(delimiters.quotationStart .. 'test' .. delimiters.quotationEnd)

function enquote (text)
  
print(delimiters.quotationStart .. text .. delimiters.quotationEnd)
  
end
print ([[\def\elquote#1{\directlua{tex.sprint(delimiters.quotationStart .. '#1' .. delimiters.quotationEnd)}]])

--elquote ('This is some longer text in Greek quotes.'}
enquote ("some greek text")