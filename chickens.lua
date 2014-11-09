local M = {}

function M.chicken ()
  return "chicken"
end

function M.chickens ()
  return "many chickens"
end

function M.ancient_chickens ()
  return "\\bgroup\\hiero\\HUGE\\char\"13171 \\egroup"
end

return {chicken           = chicken,
        chickens          = chickens,
        ancient_chickens  = ancient_chickens}
