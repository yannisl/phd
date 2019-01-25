if type(tex)=="table" then 
  print=tex.print 
  nl = "\\\\"
else
  tex = {} 
  tex.print = print
  nl = "\n"
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- tests the functions above
local file = 'Blocks.txt'
local lines = lines_from(file)

-- print all line numbers and their contents
for k,v in pairs(lines) do
  if string.match(v,"%#") or v=="" then -- skip comments and empty lines
  else
     x1,x2 = string.match(v, "(.-);(.+)") 
    print( x1, x2, nl)
  end   
end

