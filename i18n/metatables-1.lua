

t = setmetatable({ 1, 2, 3 }, {
  __tostring = function(t)
    sum = 0
    for _, v in pairs(t) do sum = sum + v end
    return "Sum: " .. sum
  end
})

z = function () 
    tex.print(t) -- prints out "Sum: 6"
  end
  
z()  