
local cells = {}

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

local s=[[\begin{tabular}{}

      \end{tabular}]]

return cells