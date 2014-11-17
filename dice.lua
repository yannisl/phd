local err, warn, info, log = luatexbase.provides_module({
     name      = 'dice',
     date       = '2014/11/01',
     version   = '0.0',
     description = 'simulating a die',
     author      = 'Y Lazarides',
     license      =  'LPPL v1.3+' ,
})

local dice =  {}    -- is this better to be local?

function dice.txprint()
    return 'dice'
end

return dice         -- return the table returns {}
