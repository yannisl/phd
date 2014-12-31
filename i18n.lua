-- phd-i18n
-- This package handles language strings
-- for translations.
-- files for languages are saved in respectively named files.
-- document module is used to load the files and the i18n main
-- module

local data ={}
data.strings = {}
local strings = data.strings

local floor, date, time, concat = math.floor, os.date, os.time, table.concat
local lower, rep, match = string.lower, string.rep, string.match

local tonumber, tostring = tonumber, tostring
-- verbose english

-- local gettext

--local _=gettext   -- unsure if this will not give problems with
-- Lua's use of _ as a nameless variable

-- The table words holds strings for localization of english numbers to words
-- this has been copied from ConTeXt.
-- @words holds values for translating numbers to words
-- 


local words = {
  [0] = "zero",
  [1] = "one",
  [2] = "two",
  [3] = "three",
  [4] = "four",
  [5] = "five",
  [6] = "six",
  [7] = "seven",
  [8] = "eight",
  [9] = "nine",
  [10] = "ten",
  [11] = "eleven",
  [12] = "twelve",
  [13] = "thirteen",
  [14] = "fourteen",
  [15] = "fifteen",
  [16] = "sixteen",
  [17] = "seventeen",
  [18] = "eighteen",
  [19] = "nineteen",
  [20] = "twenty",
  [30] = "thirty",
  [40] = "forty",
  [50] = "fifty",
  [60] = "sixty",
  [70] = "seventy",
  [80] = "eighty",
  [90] = "ninety",
  [100] = "hundred",
  [1000] = "thousand",
  [1000^2] = "million",
  [1000^3] = "billion",
  [1000^4] = "trillion",
}

local function translate(n)
  local w = words[n]
  if w then
    return w
  end
  local t = { }
  local function compose_one(n)
    local w = words[n]
    if w then
      t[#t+1] = w
      return
    end
    local a, b = floor(n/100), n % 100
    if a == 10 then
      t[#t+1] = words[1]
      t[#t+1] = words[1000]
    elseif a > 0 then
      t[#t+1] = words[a]
      t[#t+1] = words[100]
      -- don't say 'nine hundred zero'
      if b == 0 then
        return
      end
    end
    if words[b] then
      t[#t+1] = words[b]
    else
      a, b = floor(b/10), n % 10
      t[#t+1] = words[a*10]
      t[#t+1] = words[b]
    end
  end
  local function compose_two(n,m)
    if n > (m-1) then
      local a, b = floor(n/m), n % m
      if a > 0 then
        compose_one(a)
      end
      t[#t+1] = words[m]
      n = b
    end
    return n
  end
  n = compose_two(n,1000^4)
  n = compose_two(n,1000^3)
  n = compose_two(n,1000^2)
  n = compose_two(n,1000^1)
  if n > 0 then
    compose_one(n)
  end
  return #t > 0 and concat(t," ") or tostring(n)
end

data.english = {
  words      = words,
  translate  = translate,
  dir        = "LTR",
  name       = "english"
}

data.en = data.english

local test = function () 
 print(translate(165))
 print(translate(1900))
 print(translate(1111))
 print(translate(1218))
 print(translate(1234))
 print(translate(12345))
 print(translate(1234567))
 print(assert(translate(1900)=="one thousand nine hundred", "passed"))
end


strings.en = {
  abstract          = "abstract",
  partname          = "part",
  chaptername       = "chapter",
  sectionname       = "section",
  subsectionname    = "subsection",
  subsubsectionname = "subsubsection",
  paragraphname     = "paragraph",
  appendixname      = "appendix", 
  bibliographyname  = "bibliography",
  indexname         = "Index",
  glossaryname      = "Glossary",
  tablename         = "Table",
  figurename        = "figure", 
  pagename          = "page",
  seename           = "see",
  equationname      = "equation",
  contentsname      = "contents",
  prefacename       = "preface",
  listfigurename    = "List of Figures",
  listtablename     = "List of Tables",
  alsoname          = "see also",
  proofname         = "Proof",
  references        = "References"
}

 
  -- strings from polglossia and google translate
  -- 
  
-- latex interface
-- commands to latex are by means of keys
-- keys are treated as tables when passed to lua
-- command factory translate all strings to tex definitions

local texcommands = {}

texcommands.gettext = function (k,v,lang)
   return [[\def\]]..lang..k..'{'.. v .. [[}%]]
end


-- given a language creates a TeX definition
-- for the date
-- @return \def\datefinnish etc.
--
texcommands.dates = function (lang)
  local str, xs  = '', ''
        xs = '\\def\\date'..lang..[[{%
   \def\today{\number\day.~\ifcase\\month]]
   
   for k,v in pairs(strings[lang].months) do
     str = str .. '\\or \n ' .. v
   end
   
   xs = xs .. str ..[[ \fi
    \space\number\year]]
  return print(xs)
    
end  

 
local test_language = function (lan)
  for k,v in pairs (strings[lan],lan) do
    if v == nil or v =="" or k =='months' then 
      if strings.en[k] then v = tostring(strings.en[k]) -- defaults to english
                                                        -- if string is missing
      else
        v = tostring(k)
        end
      end
      print(texcommands.gettext(k,v,lan))
  end
end

-- language tests

--test_language('icelandic')
--test_language('ancientgreek')
--test_language('greek')
--test_language('swedish')
--test_language('german')
--test_language('finnish')
--test_language('albanian')
--test_language('asturian')


--texcommands.dates("turkish")
--texcommands.dates("russianold")
--texcommands.dates("samin")
--texcommands.dates("scottish")
--texcommands.dates("serbian")
--texcommands.dates("slovenian")
--texcommands.dates("spanish")
--texcommands.dates("tamil")
--texcommands.dates("tamil")
--texcommands.dates("tibetan")
--texcommands.dates("usorbian")

--local x = os.clock()*1000
--    local s = 0
--    for i=1,1000000 do s = s + i end
--    print(string.format("elapsoed time: %.2f\n %s", os.clock()*1000  -x , 'ms'))
    
local s = os.date('!%a, %d %b %Y %H:%M:%S GMT')

print(s)

local strings = require ("greek")
require("phd-scripts")
return data   

