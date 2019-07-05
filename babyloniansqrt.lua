-- babylonian square roots

local x = 125348   -- number to determine square root
local xguess = 600 -- initial guess

local series = {} -- will store a series of solutions

local generate = function() 
   local str = ""  

   for i=0,4 do  
      local result = 0.5*(xguess + (x/xguess))
      xguessstr = string.format("%.3f",xguess)
      resultstr = string.format("%.3f",result) 
      str = "x_".. i ..
        " & = \\\\frac{1}{2} \\left(x_0 + \\frac{S}{x_0}\right) & = \\frac{1}{2} \\left("..
        xguessstr..
        " + \\frac{x}{" ..
        xguessstr..
        "}\\right) & = " .. 
        resultstr .. 
        " \\\\[0.3em] "
      table.insert(series, str)
      xguess=result
    end  
end

table.insert(series,"\\begin{align}")
table.insert(series,"\\begin{array}{rlll}")
generate()
table.insert(series,"\\end{array}")
table.insert(series,"\\end{align}")


for _,v in ipairs(series) do
  print(v)
end

sum = 0
n = 7


for i = 1, 5 do sum = sum + n^i 
  print(sum)
end

print(2^5)


local d = 189 / 60
print (math.floor(d))

x = 1234
r = ""
base = 8

while x > 0 do
    r = "" ..  (x % base ) .. r
    x = math.floor(x / base)
end
print( r );