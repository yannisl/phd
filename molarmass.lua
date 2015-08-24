-- Computes the mollar mass from simple chemical formulae
--    like H2O, NH3, CuSO4, Si(OH)4, 
--
-- Based on code at Media Wiki
-- Y Lazarides
-- Lua Module to calculate molar mass  

local c = {} -- module's table

local am = {}  -- Atomic Mass table 
am.H=1.00794; am.He=4.002602; am.Li=6.941; am.Be=9.012182; 
am.B=10.811; am.C=12.0107; am.N=14.00674; am.O=15.9994; 
am.F=18.9984032; am.Ne=20.1797; am.Na=22.98976928; am.Mg=24.3050; 
am.Al=26.9815386; am.Si=28.0855; am.P=30.973762; am.S=32.066; 
am.Cl=35.4527; am.Ar=39.948; am.K=39.0983; am.Ca=40.078; 
am.Sc=44.955912; am.Ti=47.867; am.V=50.9415; am.Cr=51.9961; 
am.Mn=54.938045; am.Fe=55.845; am.Co=58.933195; am.Ni=58.6934; 
am.Cu=63.546; am.Zn=65.39; am.Ga=69.723; am.Ge=72.61; 
am.As=74.92160; am.Se=78.96; am.Br=79.904; am.Kr=83.80;
am.Rb=85.4678; am.Sr=87.62; am.Y=88.90585; am.Zr=91.224; 
am.Nb=92.90638; am.Mo=95.94; am.Tc=97.9072; am.Ru=101.07; 
am.Rh=102.90550; am.Pd=106.42; am.Ag=107.8682; am.Cd=112.411; 
am.In=114.818; am.Sn=118.710; am.Sb=121.760; am.Te=127.60; 
am.I=126.90447; am.Xe=131.29; am.Cs=132.9054519; am.Ba=137.327;       
am.Hf=178.49; am.Ta=180.94788; am.W=183.84; am.Re=186.207; 
am.Os=190.23; am.Ir=192.217; am.Pt=195.084; am.Au=196.966569; 
am.Hg=200.59; am.Tl=204.3833; am.Pb=207.2; am.Bi=208.98040; 
am.Po=208.9824; am.At=209.9871; am.Rn=222.0176;am.La=138.90547; 
am.Ce=140.116; am.Pr=140.90765; am.Nd=144.242; am.Pm=144.9127; 
am.Sm=150.36; am.Eu=151.964; am.Gd=157.25; am.Tb=158.92535; 
am.Dy=162.500; am.Ho=164.93032; am.Er=167.259; am.Tm=168.93421; 
am.Yb=173.04; am.Lu=174.967;am.Fr=223.0197; am.Ra=226.0254;         
am.Rf=263.1125; am.Db=262.1144; am.Sg=266.1219; am.Bh=264.1247; 
am.Hs=269.1341; am.Mt=268.1388; am.Ds=272.1463; am.Rg=272.1535; 
am.Cn=277.0; am.Uut=284.0; am.Fl=289.0; am.Uup=288.0; 
am.Lv=292.0; am.Uus=292.0; am.Uuo=101.3; am.Ac=227.0277; 
am.Th=232.03806; am.Pa=231.03588; am.U=238.02891; am.Np=237.0482; 
am.Pu=244.0642; am.Am=243.0614; am.Cm=247.0703; am.Bk=247.0703; 
am.Cf=251.0796; am.Es=252.0830; am.Fm=257.0951; am.Md=258.0984; 
am.No=259.1011; am.Lr=262.110;
 
local T_ELEM = 0  -- token types
local T_NUM = 1
local T_O = 2    -- open '('
local T_C = 3    -- close ')'
 
function item(f) -- (iterator) returns one token (type, value) at a time from the formula 'f'
   local i = 1
   return function ()
	local t, x = nil, nil
	if i <= f:len() then
			      x = f:match('^%u%l*', i); t = T_ELEM;  -- matching elem (C, O, Ba, Na,...)
		if not x then x = f:match('^%d+', i); t = T_NUM; end -- matching number
		if not x then x = f:match('^%(', i); t = T_O; end    -- matching '('
		if not x then x = f:match('^%)', i); t = T_C; end    -- matching ')'
		if x then i = i + x:len(); else i = i + 999; error("Invalid character in formula : "..f) end
		end
	return t, x
	end
 end
 
function c.mm(f) -- molar mass of the formula 'f'
  
   local sum, cur = {0}, {0}  -- stacks to handle '()' ; 'cur' awaits to be multiplied (or not)
   local t, x
   for t, x in item(f) do 
	if     t == T_ELEM then if not am[x] then error("Unknown element : "..x) end
                            sum[#sum] = sum[#sum] + cur[#cur]; cur[#cur] = am[x]
	elseif t == T_NUM  then sum[#sum] = sum[#sum] + cur[#cur] * tonumber(x); cur[#cur] = 0
	elseif t == T_O    then sum[#sum] = sum[#sum] + cur[#cur]; cur[#cur] = 0;sum[#sum+1] = 0; cur[#cur+1] = 0 -- push
	elseif t == T_C    then if #sum < 2 then error("Too many ')' in "..f) end
				sum[#sum] = sum[#sum] + cur[#cur]; cur[#cur-1] = sum[#sum]; sum[#sum], cur[#cur] = nil, nil -- pop
	else error('???') end -- in fact, unreachable
   end
   if #sum > 1 then error("Too many '(' in "..f) end
   return sum[1] + cur[1]
end

local inlua = false

function test_mm(f)
  if inlua then
      print('The molar mass of '..f..' is '..c.mm(f))
    else
      tex.print('The molar mass of \\ce{'..f..'} is '..c.mm(f),'\\si{\\gram\\per\\mol}\\par')
  end    
end
    
--test_mm("NaCl")
--test_mm("NaOH")
--test_mm("CaCO3")
--test_mm("H2SO4")
--test_mm("C10H8")
--test_mm("CO2")
--test_mm("Mo")
--test_mm("HCl")
--test_mm("Si(OH)4")
--test_mm("CuSO4(H20)5")
--test_mm("H2O")
--test_mm("SB2O3")




return c -- exports c.mm()