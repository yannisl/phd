-- working URM machine
-- An Unlimited Register Machine
local M = M or {}

M.length = 7

M.regState = {}
-- creator function for registers
function M.registers()
  
end

-- initialize registers
function M.init()
  for i=1, M.length do
    M.regState[i] = i*i
  end  

end

-- renders the current state of the machine
function M.renderInitial() 
  local s=""
  -- first cell
  print("r_"..M.regState[1])
  for i=2, M.length do
    print("r_"..M.regState[i])
  end

end

-- renders the current state of the machine
function M.render() 
  local s=""
  -- first cell
  print("r_"..M.regState[1])
  for i=2, M.length do
    print(M.regState[i])
  end
end
 
-- renders a URM diagram in LaTeX
-- given t = {...} 
-- R1 R2 R3 ... 
function M.RenderFromTable(t)
  local len = #t
  local out, s="","|"
  -- build the array specification
  for i=1,#t-1 do
    s=s.."c|"
  end  
  out= string.format("\\begin{array}".."{"..s.."c}\\hline ")
    
  -- build row 
  out=out.."R_1"
  for i=2, #t do 
    out=out .. "&R_"..i
  end 

  --print("\\dots")
  out = out.."\\\\\\hline "
  out = out.. t[1] -- print first cell
  for k,v in ipairs(t) do
    if k>1 then out = out .. "&"..v end
  end  
  out = out .. "\\\\\\hline\\end{array}"
  tex.print(out)
end  

-- sets a value 
-- n register value
-- m the value
M.Set = function(n,val)
        M.regState[n] = val
      end

M.Inc = function(n)
          M.regState[n] = M.regState[n] + 1
        end 

-- M.regState ={0,3,27,22,78,99,88}
-- M.renderInitial()
-- M.Set(5,99999)
-- M.Inc(5)
-- M.render()

-- M.RenderFromTable({0,1,2,3,4,5,666})
-- 5.2.0-beta-rc2
--for z=1,10 do
--for y=1,10 do
--for x=1,10 do
--  if x^2 + y^2 == z^2 then
--    print('found a Pythagorean triple:', x, y, z)
--    goto done
--  end
--end end end
--::done::

return M