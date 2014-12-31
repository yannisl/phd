----
-- phd-i18n
-- This package handles language strings
-- for translations.
-- files for languages are saved in respectively named files.
-- document module is used to load the files and the i18n main
-- module


strings = {}


local floor, date, time, concat = math.floor, os.date, os.time, table.concat
local lower, rep, match = string.lower, string.rep, string.match

local tonumber, tostring = tonumber, tostring
-- verbose english

-- local gettext

--local _=gettext   -- unsure if this will not give problems with
-- Lua's use of _ as a nameless variable

-- The table words holds strings for localization of english numbers to words
-- this has been copied from ConTeXt.
-- @param words holds values for translating numbers to words
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

---
-- @function translate
-- @param n number to be changed to word
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

--data.english = {
--  words      = words,
--  translate  = translate,
--  dir        = "LTR",
--  name       = "english"
--}

--data.en = data.english

--local test = function () 
-- print(translate(165))
-- print(translate(1900))
-- print(translate(1111))
-- print(translate(1218))
-- print(translate(1234))
-- print(translate(12345))
-- print(translate(1234567))
-- print(assert(translate(1900)=="one thousand nine hundred", "passed"))
--end


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

    local counter = 1

    local test_language = function (lan,language)
      language = string.lower(language) -- ensure it is lower case
      strings = require(lan)
      for k,v in pairs (strings[language]) do
        if v == nil or v =="" or type(v) =='table' then 
          if strings.en[k] then v = tostring(strings.en[k]) -- defaults to english
            -- if string is missing
          else
            v = tostring(k)
          end
        end
        print(texcommands.gettext(k,v,lan))
      end
      counter = counter + 1
    end

------------------------------------------------------------------------
-- Provide some tests for all the languages.
-- These are mostly tests that output LaTeX and can be visually examined.

--test_language('albanian')
--test_language('armenian')
--test_language('asturian')

--test_language('bahasai')
--test_language('basque')
--test_language('Breton')       -- does not fail on caps
--test_language('bulGariaN')    -- ditto

--test_language('catalan')
--test_language('danish')

--test_language('esperanto')
--test_language('finnish')
--test_language('french')

--test_language('german')
    test_language('el.greek','greek')

--test_language('hindi')

--test_language('icelandic')
--test_language('irish')
--test_language('italian')

--test_language('japanese')  -- minimum support
--test_language('kannada')

--test_language('latin')
--test_language('lao')
--test_language('latvian')
--test_language('lithuanian')
--test_language('lsorbian')

--test_language('magyar')
--test_language('malayalam')
--test_language('marathi')

--test_language('nko')
--test_language('norsk')

--test_language('occidan')

--test_language('piedmontese')
--test_language('polish')
--test_language('portuges')

--test_language('romanian')
--test_language('romansh')

--test_language('swedish')
--test_language('german')
--test_language('finnish')

--test_language('russian')
--test_language('samin')

--test_language('scottish')
--test_language('serbian')
--test_language('slovak')
--test_language('slovenian')
--test_language('spanish')
--test_language('swedish')

--test_language('tamil')
--test_language('tibetan')
--test_language('tulugu')
--test_language('turkish')
--test_language('turkmen')

--test_language('ukrainian')
--test_language('urdu')
--test_language('usorbian')
--test_language('vietnamese')
--test_language('welsh')
--test_language('zulu')


    print ('number languages', counter)

    local x = os.clock()*1000
    local s = 0
    for i=1,1000000 do s = s + i end
    print(string.format("elapsed time: %.2f\n %s", os.clock()*1000  -x , 'ms'))

    local s = os.date('!%a, %d %b %Y %H:%M:%S GMT')

    print(s)

--- enables path settings
--  unbelievable but it worked!
    local test = require("el.test")
    local languages = require("el.languages")
    local units = require("el.units")
    local transformNames = require("el.transformnames")
    local ca_generic = require("el.cageneric")
    local ca_gregorian = require("el.cagregorian")
    local layout = require("el.layout")
    local datefields = require("el.datefields")
--local characters = require("el.characters")
--local json = require("cjson")

    s = languages.localeDisplayNames.languages.en

    s1= ca_generic['el'].identity.version._number
    s2 = ca_generic['el'].dates.calendars.generic.days.formats.wide.sun
    s3 = ca_generic['el'].dates.calendars.generic.quarters.formats.wide[1]
    s4 = ca_gregorian['el'].dates.calendars.gregorian.days.formats.wide.sun
    orientation = layout.el.layout.orientation.characterOrder
    if orientation == "left-to-right" then orientation = '\\LTR' end

    s5 = datefields.el.dates.fields.year_narrow.relative_type_1

-------------------------------------------------------------
-- test for characters module
-- @arg  the language being tested
-- @return returns table with parameters
-- main.lan.characters.exemplarCharacters
--                    .auxiliary
--                    .punctuation
--                    .index
--                    .ellipsis
--                    .ellipsis.initial
--                             .medial
--                             .final
--                             .word_initial
--                             .word_medial
--                             .word_final
--                     .moreInformation
--
    local test_characters = function (lan)
      local characters = require(lan..".characters")
      local s=characters[lan].characters.index
      return print('index characters', s) 
    end  

    test_characters('ar')  
    

    local test_currencies = function (lan)
      local currencies = require(lan..".currencies")
      return currencies 
    end  

    local currencies = test_currencies('el')
    s7 = currencies.el.numbers.currencies.AFA.displayName
    s8 = currencies.el.numbers.currencies.GBP.symbol

    local test_localeDisplayNames = function (lan)
      local localeDisplayNames = require(lan..".localedisplaynames")
      return localeDisplayNames 
    end

    local localeDisplayNames = test_localeDisplayNames('el')
    s9 = localeDisplayNames.el.localeDisplayNames.keys.calendar  

    local test_measurementSystemNames = function (lan)
      local measurementSystemNames = require(lan..".measurementsystemnames")
      return measurementSystemNames
    end  
    local measurementSystemNames = test_measurementSystemNames('el')
    local s10 = measurementSystemNames.el.localeDisplayNames.measurementSystemNames.US

----------------------------------------------------------------
    local test_numbers = function (lan)
      local numbers = require(lan..".numbers")
      return numbers 
    end

    local numbers = test_numbers('el')        
    local s11 = numbers.el.numbers.decimalFormats_numberSystem_latn.short.decimalFormat["1000_count_one"]

---------------------------------------------------------------
-- test scripts
--
    local test_scripts = function (lan)
        local scripts = require(lan..".scripts")
        return scripts
    end

  local scripts = test_scripts('el')
  s12 = scripts.el.localeDisplayNames.scripts.Nkoo

---------------------------------------------------------------
-- test variants
local test_variants = function (lan)
        local variants = require(lan..".variants")
        return variants
    end

local variants = test_variants('el')

s13 = variants.el.localeDisplayNames.variants.BISKE


local test_territories = function (lan)
  local territories = require(lan..".territories")
        return territories
  end
  
local territories = test_territories('el')  

s14 = territories.el.localeDisplayNames.territories["015"]

local test_timeZoneNames = function (lan)
  local timeZoneNames = require(lan..".timezonenames")
        return timeZoneNames
  end
  
local timeZoneNames = test_timeZoneNames('el')

s15 = timeZoneNames.el.dates.timeZoneNames.zone.Asia.Dubai.exemplarCity  

local test_cacoptic = function (lan)
  local cacoptic = require(lan..".cacoptic")
        return cacoptic
  end

local cacoptic = test_cacoptic('el')

s16 = cacoptic.el.dates.calendars.coptic.months.format.abbreviated["1"]

---
-- dangi calendar
--

local test_cadangi = function (lan)
  local cadangi = require(lan..".cadangi")
        return cadangi
  end

local cadangi = test_cadangi('el')

s16 = cadangi.el.dates.calendars.dangi.cyclicNameSets.years.format.abbreviated["1"]

local test_calendar = function (lan, calendar)
  local cal = require(lan..'.'..'ca'..calendar)
  local s = cal[lan].dates.calendars[calendar].months.format.wide[tostring(1)]
  return cal,s
end

local c,s17 = test_calendar('el','ethiopic')
local c1,s18 = test_calendar('el','islamic')
local c2,s19 = test_calendar('el','buddhist')
local c3,s20 = test_calendar('el','chinese')

-----------------------------------------------------------------
-- arabic test
-- 
local test_timeZoneNames = function (lan)
  local timeZoneNames = require(lan..".timeZoneNames")
        return timeZoneNames
  end
  
  local timeZoneNames = test_timeZoneNames('ar')
  
  s21 = timeZoneNames.ar.dates.timeZoneNames.zone.Asia.Dubai.exemplarCity  
  print(s, s1, s2, s3, s4, orientation, s5, s6, s7, s8, s9, s10, s11, s12,  s13, s14, s15, s16, s17, s18, s19, s20, s21)
  
  local m = require("ar.ca-buddhist")
  local str = m.ar.dates.calendars.buddhist.months.stand_alone.narrow
  for k,v in pairs(str) do 
     print("December buddhist calendar written in Arabic", str[k])
  end
  
  
  
  
  
return data   

