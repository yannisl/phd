local lfs = require"lfs"
local currdir = lfs.currentdir ()
local blocks = {}

currdir = string.gsub(currdir,"\\","/")

if type(tex)=="table" then 
  print=tex.print 
  nl = "\\\\"
else
  tex = {} 
  tex.print = print
  nl = "\n"
end

function file_exists(filename)
  local f = io.open(filename, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(filename)
  if not file_exists(filename) then 
    tex.print("Cannot find file", filename)
    return {} 
  end
  lines = {}
  for line in io.lines(filename) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local ranges = {}
 
function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end 
 
function insert_in_table(x1,x2,x3)
  local lrange, erange 
  local keyname = trim(x3)
  local m = {lrange=x1, erange=x2}
       ranges[keyname] = m
          
end  

local filename = currdir.."/i18n/ucd/Blocks.txt"
local lines = lines_from(filename)
local noblocks = 0

-- print all line numbers and their contents
print('\n\\bgroup\\parindent=0pt\\begin{longtable}{>{\\arial}l>{\\arial}l}%') 
for k,v in pairs(lines) do
  if string.match(v,"%#") or v=="" then -- skip comments and empty lines
  else
    x1,x2,x3 = string.match(v, "^(%x+)%p+(%x+);(.+)") 
    insert_in_table(x1,x2,x3)
    tex.print(x1.."\\ldots "..x2.."&"..x3..'\\\\ \\index{'..x3..'}')
    noblocks = noblocks + 1
  end   
end
print("\\end{longtable}".."\n\\egroup\n")
print("No Blocks = "..noblocks)
--for k,v in pairs(ranges) do
--  print(k, v.lrange, v.erange)
-- end
tex.print(filename)
tex.print(ranges["Glagolitic"].lrange, ranges["Glagolitic"].erange)

