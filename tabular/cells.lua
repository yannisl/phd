
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
   --print(cells[i])
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
--local tex = {
 --sprint = print}
---
-- Based on code at ConTeXt wiki
-- \url{http://wiki.contextgarden.net/wikitable}
--
function wiki_to_table (str) 
   -- heading get first line
   str = string.gsub(str,"%^ *[\n\r]","\\tabularnewline \n")
   str = string.gsub(str,"^%^"," ")
   str = string.gsub(str,"%^","&")
--  first line of body
   str = string.gsub(str,"| *[\n\r]","\\tabularnewline\n")
   str = string.gsub(str,"|","& ")
   
   tex.sprint("\\begin{tabular}{lll} ")
   tex.sprint("\\toprule ")
   tex.sprint(str)
   tex.sprint("\\\\ \\bottomrule")
   tex.sprint("\\end{tabular} ")
   --print(str)
end



--wiki_to_table([[
-- Heading 1 ^ Heading 2  ^Heading 3|
-- \\  \midrule
-- Item 1    | Item 2 | Item 3 |
-- Item 4    | Item 5 | Item 6 |
-- ]]
--)
if type(tex) == 'table' then print = tex.print end
local t = {
    document_type = {'article'},
    geometry = {
       paper = 'a4'
     }
  } 
 print(t.geometry['paper'])
if type(tex) == 'table' then print = tex.print end
local paper = {'a4', 'a3', 'a2', 'a1', 'a5', 'a0' }
for k,v in pairs(paper) do
   print(v)
end
table.sort(paper)
for k,v in pairs(paper) do
   print(v)
end


if type(tex) == 'table' then print = tex.print end
local students = {
  {name = 'John', avg = '80'},
  {name = 'Mary', avg = '66'},
  {name = 'David', avg = '99'}, 
  {name = 'Patel', avg ='98'},
  {name = 'Anne', avg = '52'},
  {name = 'Zavier', avg = '87'} 
}

local descending = function (a, b) return (a.avg > b.avg) end
local ascending = function (a, b) return (a.avg < b.avg) end

table.sort(students, descending)
           

for k, v in pairs(students) do
  print(v.name, v.avg)
end


if type(tex) == 'table' then print = tex.print end
 students = {
  {name = 'John', avg = '80'},
  {name = 'Mary', avg = '66'},
  {name = 'David', avg = '99'}, 
  {name = 'Patel', avg ='98'},
  {name = 'Anne', avg = '52'},
  {name = 'Zavier', avg = '87'} 
}



table.sort(students, ascending)
 
 
for k, v in pairs(students) do
  print('\\begin{longtable}{ll}')
  print(v.name ..'&'..  v.avg .. '\\\\')
  print('\\end{longtable}')
end

for k, v in pairs(students) do
  print('\\begin{tabular}{ll}')
  print(v.name ..'&'..  v.avg .. '\\\\')
  print('\\end{tabular}')
end

if type(tex) == 'table' then print = tex.print end
 students = {
  {name = 'Peter', avg = '52'}, 
  {name = 'John', avg = '80'},
  {name = 'Mary', avg = '66'},
  {name = 'David', avg = '99'}, 
  {name = 'Patel', avg ='98'},
  {name = 'Anne', avg = '52'},
  {name = 'An', avg = '52'},
  {name = 'Zavier', avg = '87'} 
}

table.insert(students, 5, {name='Annabel', avg='52'})

local descending = function (a, b) return (a.avg > b.avg) end
local ascending = function (a, b) return (a.avg < b.avg) end

--table.sort(students, descending)   

print('\\begin{tabular}{ll}')
for _, v in pairs(students) do
   --print(v.name ..'&'..  v.avg .. '\\\\')
   print(v.name)
end
print('\\end{tabular}')

set = {}
t1 = {'a','yannis',wei='wei'}
function set.contains(n,s)
    if type(n) == "table" then
        print('table')
        return n[s]
    elseif n == 0 then
        return false
    else
        local t = tabs[n]
        return t and t[s]
    end
end

print(set.contains(t1,'wei'))
TeX = {}
TeX.escaped = {
  
     ["{"] = "\\{",
     ["}"] = "\\}",
     ["$"] = "\\$",
     ["%"] = "\\%",
     ["&"] = "\\&",
     ["_"] = "\\_",
     ["#"] = "\\#",
     ["^"] = "\\^{}",
     ["\\"] = "\\char92{}",
     ["~"] = "\\char126{}",
     ["|"] = "\\char124{}",
     ["<"] = "\\char60{}",
     [">"] = "\\char62{}",
     ["["] = "{[}", -- to avoid interpretation as optional argument
     ["]"] = "{]}",
   }
   
print(TeX.escaped["["]) 

   
return cells

