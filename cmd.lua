---
-- module cmd
-- 
local m = m or {}
local print = print

if type(tex)== "table" then   
   print = tex.print
   print(type(tex))
end

m.csname = function (a, b) 
  return print("\\expandafter\\gdef\\csname"..'@'..a.."\\endcsname{"..b.."}")
end  

m.def = function (a, b) 
  return print("\\gdef\\"..a.."{"..b.."}")
end  

return m
