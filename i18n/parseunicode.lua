if type(tex)=="table" then 
  print=tex.print 
  nl = "\\\\"
else
  tex = {} 
  tex.print = print
  nl = "\n"
end
-- parse
local s ={}
      s[1] = "10107;AEGEAN NUMBER ONE;No;0;L;;;;1;N;;;;;"
      s[2] = "10108;AEGEAN NUMBER TWO;No;0;L;;;;2;N;;;;;"
      s[3] = "10109;AEGEAN NUMBER THREE;No;0;L;;;;3;N;;;;;"
      s[4] = "1010A;AEGEAN NUMBER FOUR;No;0;L;;;;4;N;;;;;"
      s[5] = "1010B;AEGEAN NUMBER FIVE;No;0;L;;;;5;N;;;;;"
      s[6] = "1010C;AEGEAN NUMBER SIX;No;0;L;;;;6;N;;;;;"

local t = {}


function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    if  string.sub(str,pos,st-1)=="" then
      table.insert(arr,"n/a") -- Attach chars left of current divider
    else
      table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    end  
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end


local hex2number = function (n)
  --print(n)
  return tonumber(n,16)
end  


for i=1,1 do --#s
 arr = explode(";", s[i])

  local hex = arr[1]
  --- Returns HEX representation of str
  
  
  
 hexstr= tonumber(arr[1])
 --print(i, "HEX",hex, hexstr) 

 if (hex2number(arr[1]) and hex2number(arr[1]) <= 65800) then
   
    print("Codepoint (hex): "..arr[1]..nl,-- codepoint
           "Codepoint (dec): "..hex2number(arr[1])..nl,
          "Character Name: ".."\\lowercase{"..arr[2].."}"..nl,-- character name 
          "General Category: "..arr[3]..nl,-- General Category 
          "Canonical Combining classes: "..arr[4]..nl,-- Canonical combining classes
          "Biderectional Category: "..arr[5]..nl,-- Bidirectional Category 
          "Character Decomposition Mapping: "..arr[6]..nl,-- Character Decomposition Mapping
          "Decimal Digit Value: ",arr[7]..nl,-- Decimal digit value
          "Digit Value: ",arr[8]..nl,-- Digit value
          "Numeric Value: ", arr[9]..nl,-- Numeric value
          "Mirrored: "..arr[10]..nl,-- Mirrored
          "Unicode 1 name: "..arr[11]..nl,-- Unicode 1 name
          "Comment field: ",arr[12]..nl,-- comment field
          "Uppercase mapping: "..arr[13]..nl,-- uppercase mapping
          "Lowercase mapping: "..arr[14]..nl,-- lowercase mapping
          "Titlecase mapping: "..arr[15]..nl)-- titlecase mapping
    tex.print("Symbol: \\bgroup\\bfseries\\Large\\char\""..arr[1].."\\egroup"..nl)   
    tex.print("\\newline")
    --tex.print("\\columnbreak")
  end
end







