-- Make the facilities available
unicode = require( 'unicode' )
utf8 = unicode.utf8

--[[
    Each character's position in this array-like table determines its 'priority'.
    Several characters in the same slot have the same 'priority'.
]]
local alphabet =
{
    -- The space is here because of other requirements of my project
    { ' ' },
    { 'a', 'á', 'à', 'ä' },
    { 'b' },
    { 'c' },
    { 'd' },
    { 'e', 'é', 'è', 'ë' },
    { 'f' },
    { 'g' },
    { 'h' },
    { 'i', 'í', 'ì', 'ï' },
    { 'j' },
    { 'k' },
    { 'l' },
    { 'm' },
    { 'n' },
    { 'ñ' },
    { 'o', 'ó', 'ò', 'ö' },
    { 'p' },
    { 'q' },
    { 'r' },
    { 's' },
    { 't' },
    { 'u', 'ú', 'ù', 'ü' },
    { 'v' },
    { 'w' },
    { 'x' },
    { 'y' },
    { 'z' }
}

-- Looks up the character `character´ in the alphabet and returns its 'priority'
local function get_pos_in_alphabet( character )
    for i, alphabet_entry in ipairs(alphabet) do
        for _, alphabet_char in ipairs(alphabet_entry) do
            if character == alphabet_char then
                return i
            end
        end
    end

    --[[
        If it isn't in the alphabet, abort: it's better than silently outputting some
        random garbage, and, thanks to the message, allows to add the character to
        the table.
    ]]
    assert( false , "'" .. character .. "' was not in alphabet" )
end

-- Returns the characters in the UTF-8-encoded string `s´ in an array-like table
local function get_utf8_string_characters( s )
    --[[
        I saw this variable being used in several code snippets around the Web, but
        it isn't provided in my LuaTeX environment; I use this form of initialization
        to be safe if it's defined in the future.
    ]]
    utf8.charpattern = utf8.charpattern or "([%z\1-\127\194-\244][\128-\191]*)"

    local characters = {}

    for character in s:gmatch(utf8.charpattern) do
        table.insert( characters , character )
    end

    return characters
end

local function compare_utf8_strings( _o1 , _o2 )
    --[[
        `o1_chars´ and `o2_chars´ are array-like tables containing all of the
        characters of each string, which are all made lower-case using the
        slnunicode facilities that come built-in with LuaTeX.
    ]]
    local o1_chars = get_utf8_string_characters( utf8.lower(_o1) )
    local o2_chars = get_utf8_string_characters( utf8.lower(_o2) )

    local o1_len = utf8.len(o1)
    local o2_len = utf8.len(o2)

    for i = 1, math.min( o1_len , o2_len ) do
        o1_pos = get_pos_in_alphabet( o1_chars[i] )
        o2_pos = get_pos_in_alphabet( o2_chars[i] )

        if o1_pos > o2_pos then
            return false
        elseif o1_pos < o2_pos then
            return true
        end
    end

    return o1_len < o2_len
end