-- presents nicely a table 

local M = M or {}

local rep, write = string.rep, tex.print

function M.inspect (tab, offset)
   local openbracket, closebracket, par = "\\{", "\\mbox{..}\\}", "\\par"
   
    offset = offset or ""
    for k, v in pairs (tab) do
        local newoffset = offset .. "\\mbox{~~}"
        if type(v) == "table" then
           write(offset .. k .. " = " .. openbracket .. par)
           M.inspect(v, newoffset)
           write(offset .. closebracket .. par)
        else
         if k~="data" then write(offset..k.." =  ".. tostring(v), "\\par") 
           else
                 write(offset.."k = char data ")
           end
       end
    end
end

return M