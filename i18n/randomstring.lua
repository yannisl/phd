local random = math.random
local char = string.char
local concat = table.concat
--- Generate a random string.
--
-- You can either provide your own charset or the function will use
-- a default one which is [A-Z].
-- @param len Length of the string we want to generate.
-- @param charset Charset that will be used to generate the string.
-- @return A random string of length <code>len</code> consisting of
-- characters from <code>charset</code> if one was provided, otherwise
-- <code>charset</code> defaults to [A-Z] letters.
function generate_random_string(len, charset)
  local t = {}
  local ascii_A = 65
  local ascii_Z = 90
  if charset then
    for i=1,len do
      t[i]=charset[random(#charset)]
    end
  else
    for i=1,len do
      t[i]=char(random(ascii_A,ascii_Z))
    end
  end
  return concat(t)
end

print(generate_random_string(150,{'a','b','c',';','d','e',',','f.'}))