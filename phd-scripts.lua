---
-- @script     script as defined in unicode
-- @languages  as defined in babel (minimum)
-- @fontarray  array of possible fonts windows
-- @fontarray  array of possible linux array
--

local M = M or {}

      M.scripts = {
        arabic = {windows_font = {'scherezanze','Arabic'},
                  linux_font = '',
                  os_font = ''},
        aramaic_imperial = {'Aramaic Imperial'},
        'Armenian',
        'Avestan',
        'Balinese',
        'Bamum',
        'Bassa Vah',
        'Batak', 
        'Bengali',
        'Bopomofo',
        'Brahmi',
        'Buginese',
        'Buhid',
        'Canadian Syllabic',
        'Carian',
        'Caucasian Albanian',
        'Chakma',
        'Cham',
        'Cherokee',
        'Coptic',
        'Cypriot',
        'Cyrillic',
        'Deseret',
        'Devanagari',
        'Duployan (shorthand)',
        'Egyptian Hieroglyphs',
        'Elbasan',  
        'Ethiopic',
        'Georgian',
        'Glagolitic',
        'Gothic',
        'Grantha',
        'Greek',
        'Gujarati',
        'Gurmukhi',
        'Han',
        'Hangul',
        'Hanunóo',
        'Hebrew',
        'Hiragana',
        'Javanese',
        'Kaithi',
        'Kannada','Katakana','Kayah Li',
        'Kharoshthi','Khmer','Khojki',
        'Khudawadi (Sindhi)','Lao',
        'Latin','Lepcha (Rong)','Limbu',
        'Linear A','Linear B','Lisu',
        'Lycian','Lydian','Mahajani',
        'Malayalam','Mandaic','Manichaean',
        'Meetei Mayek','Mende Kikakui',
        'Meroitic Cursive','Meroitic Hieroglyphs','Miao',
        'Modi','Mongolian','Mro',
        'Myanmar','Nabataean','New Tai Lue',
        'N\'Ko','Ogham','Ol Chiki','Old Italic (Etruscan)',
        'Old North Arabian','Old Permic','Old Persian Cuneiform',
        'Old South Arabian','Old Turkic','Osmanya',
        'Oriya','Pahawh Hmong','Pahlavi, Inscriptional',
        'Pahlavi, Psalter','Palmyrene','Parthian Inscriptional',
        'Pau Cin Hau','Phags-pa','Phoenician',
        'Rejang','Runic','Saurashtra',
        'Samaritan','Sharada','Shavian',
        'Siddham','Sinhala','Sora Sompeng',
        'Sumero-Akkadian Cuneiform','Sundanese','Syloti Nagri',
        'Syriac','Tagalog','Tagbanwa',
        'Tai Le','Tai Tham','Tai Viet',
        'Takri','Tamil','Telugu',
        'Thaana','Thai','Tibetan',
        'Tifinagh','Tirhuta (Maithili)','Ugaritic',
        'Vai','Warang Citi','Yi'
  }


M.put_scripts = function (scriptname)
  -- manages script loading and unloading
  -- 
  return table.insert(M.scripts,string.lower(scriptname))
end


M.put_scripts("greek")

print(M.scripts[1])
  





