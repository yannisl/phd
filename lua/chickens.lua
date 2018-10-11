local M = {}

local chicken = function ()
  return "one chicken\\par"
end

local chickens = function ()
  return "many chickens\\bgroup\\hiero\\Huge\\char\"13171\\char\"13170\\egroup\\par"
end

local ancientchickens = function ()
  return "\\bgroup\\hiero\\Huge\\char\"13171 \\egroup\\par"
end

return {chicken           = chicken,
        chickens          = chickens,
        ancient_chickens  = ancientchickens}
