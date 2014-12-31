
local cells, tabular, rows = {}, {}, {}
 
---
-- The function tabularize takes a variadic
-- input and adds \& to prepare it for TeX
-- output
-- 
function tabular.tabularize (...)
  local args, t = {}, {}
  local counter = 0
  for _,v in pairs(...) do
    counter = counter+1
    if counter>1 then table.insert(t, '&'..v) 
    else 
      table.insert(t,v)
    end
  end  
  -- add backslashes at end
  t[counter] = t[counter]..'\\\\ ' 
  -- print to screen for debugging
  if debug then
    for _,v in ipairs(t) do
      print(v)
    end
  end
end  



tabular.tabularize{'head1','head2','head3','head4','head5'}

tabular.tabularize{1,2,3,4,5}

tabular.booktabs = true 
tabular.data = {}
tabular.data.rows = {}


function tabular.specifier()
  local t = {
    ttype = 'tabular',  -- tabular, tabularx, longtable, etc
    rows = 0, 
    cols = 10,
    width = 'auto',     -- textwidth, dim command
    cellheight = 'auto',
    rowheight = 'auto'
  }  
end  
  

cells = {0, 1.456788,'abcdefgth',3.1,4.66,7.8999}

local maxdec = 0
for i=1, #cells do
  if type(cells[i])=='number' then
    local a,b = math.modf(cells[i])
    if string.len(b)-3>maxdec then maxdec = string.len(b)-3 
      --print(a, b, string.len(b)-3)
    end
  else
   print(cells[i])
  end 
end 

--print(maxdec)

-- we can use the string.format() to transform all the
-- cells to a numerical format to cater for the correct
-- numbers of decimals.
-- 
for i=1, #cells do
  if type(cells[i])=='number' then
    local s = string.format('%.5f',cells[i])
    print(s..', ')
  end
end

local sstart=[[\begin{tabular}{]]
  

local send=[[\end{tabular}]]

function wiki_to_table (str) 
   str = string.gsub(str,"%^ *[\n\\r]","\\NC\\NR\n")
   str = string.gsub(str,"%^","\\NC ")
   str = string.gsub(str,"| *[\n\r]","\\NC\\NR\n")
   str = string.gsub(str,"|","\\NC ")
   print("\\startTABLE")
   print(str)
   print("\\stopTABLE")
end

wiki_to_table([[
^ Heading 1 ^ Heading 2 ^
| Item 1    | Item 2 |
| Item 3    | Item 4 |
]])


return cells

