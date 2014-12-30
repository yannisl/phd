local M = {}

local chicken = function chicken ()
  return "chicken"
end

local chickens = function ()
  return "many chickens"
end

local ancient_chickens = function ()
  return "\\bgroup\\hiero\\HUGE\\char\"13171 \\egroup"
end

return {chicken                = chicken,
            chickens              = chickens,
            ancient_chickens  = ancient_chickens}
