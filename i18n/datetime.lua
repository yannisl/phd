-- module datetime
-- formats day strings
-- and converts between decimal and
-- fractional

local phd_module = phd_module or {
  datetime = {
    name          = "datetime",
    version       = 0.5,
    date          = "2014/11/11",
    description   = "datetime conversions and formatter",
    author        = "Y Lazarides",
    copyright     = "Y Lazarides",
    license       = "CC0"
  }
} 


local m = m or {}

m.language = 'en'
m.dateseparator = '-'
m.ISO = 'yyyymmdd'
m.datestring = ''
m.currenttime = ''
m.formattime = ''
m.settimeformat = ''
m.timeseparator = ':'

m.__index = m
m.type = 'daytime'

function m:new ()
  local obj = {}
  return setmetatable(obj, {
      __index = self
      })
end

if tex ~=nil then print = tex.print end

--- 
-- @param day
-- @param hour
function m:dayTimeToDecimal(d, h, m, s)
  h = h/24
  m = m*(1/(24*60))
  s = s*(1/(24*60*60)) 
  d = d + h +m + s
  print(d)
end  

-- helper function for formatting seconds strings
-- for TeX as 12^s.digits
-- see test.datetime-formatter
-- 
function m:formatseconds (seconds, precision)
  local fractional, prefix, suffix
  -- get the decimal part
  fractional  = seconds % 1
  prefix = tostring(math.floor(seconds))
  suffix = string.format('%.'..precision..'f',fractional)
  suffix = suffix *10^precision -- rounds for precision
  -- if zero precision no need for a dot
  if precision==0 then
    return (prefix..[[\textsuperscript{s}]])
  else  
    return (prefix..[[\textsuperscript{s}\kern-4pt.\kern1pt]]..suffix)
  end  
end

function m:printDayTime(d,h,min,seconds,precision)
  if precision == nil then precision=3 end
  local str = d..[[\textsuperscript{d}]]
         ..h..[[\textsuperscript{h}]]
         ..min..[[\textsuperscript{m}]]
         ..m:formatseconds(seconds, precision)
  print(str)
end  

function m:dayTimeToFractional (d, precision)
  if precision==nil then precision = 3 end
  local f = (d % 1)  -- day fraction
  local h = math.floor(f*24) -- hours
  local min = math.floor((f*24%1)*60) -- minutes
  local seconds = ((f*24%1)*60-min)*60
  -- avoid rounding error
  if seconds<0.00000000001 then seconds=0 end
  print (math.floor(d)..[[\textsuperscript{d}]]
         ..h..[[\textsuperscript{h}]]..min..[[\textsuperscript{m}]]
         .. m:formatseconds(seconds, precision)) 
  end  

--m:dayTimeToDecimal(29, 13, 44, 0.1134567)
--m:dayTimeToFractional(29.572223535378)
--m:formatseconds(12.234, 3)
--m:printDayTime(325,11,3,3.24,3)
 
-- test = m:new()
 
-- inherits all methods from m
-- test.printDayTime(325,11,3,3,24,3)

-- print(os.date('%A, %d %B, %Y'))

return m

-- end of module




