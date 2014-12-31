---
-- module csname
-- 
local m = m or {}

if tex then   
  print = tex.print
else 
  local print = print
end

m.csname = function (a, b) 
  return print("\\expandafter\\def\\csname"..a.."\\endcsname{"..b.."}")
end  

m.def = function (a, b) 
  return print("\\def\\"..a.."{"..b.."}")
end  

m.csname('test', 'this is a test')
m.def('test', 'this is a test')
return m
