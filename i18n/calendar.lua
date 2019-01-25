--[[
This module provides routines for the calculation of
Gregorian days
]]

---
-- Module calendar
-- handles calendar information for any language
-- which has a resource file.
-- Resource files are based on CLDR
-- Y Lazarides
-- 2014
-- version 1.0
-- Licence: cc0
-- 

local m = m or {}
local debug = false
local sin, cos, tan, acos = math.sin, math.cos, math.tan, math.acos

m.language = {}
m.language.default = 'English'

m.days = {'Sun', 'Mon', 'Tue', 
  'Wed', 'Thu', 'Fri', 'Sat'}
m.months = {'January', 'February', 'March', 
  'April', 'May','June',
  'July', 'August', 'September', 
  'October', 'November', 'December'}

m.months.images = {
  "sepp-01.jpg", "sepp-03.jpg", "falero.jpg", 
  "zorn.jpg", "capri.jpg", "sepp-03.jpg",
  "sepp-01.jpg", "sepp-03.jpg", "sepp-01.jpg", 
  "sepp-03.jpg", "sepp-01.jpg", "sepp-03.jpg",
}

m.options = {
  box_width = "2.1em",  
  bidi = "LTR",
  font = "",
  days_in_row = 14,
  previous_month_color = 'gray',
  next_month_color = 'gray',
  first_day_of_week = 1,
  first_day_of_week_color = "red",
}    


if tex ~=nil then print = tex.print end
-- sets the default language. This needs to be captured
-- from document.config

m.setLanguageDefault = function (language)
  m.language.default = language
end 

m.getLanguageDefault = function ()
  return m.language.default
end  



--- Calculate the Julian Day
-- Julian Day
-- @param year  this sijjj 
-- @param month kkll
-- @param Day    the day as two digits.
-- @param julian switch
-- 
function m.julianDay(year, month, Day, julian)
  local A, B, JD 
  if month<2 then
    year = year-1
    month = month + 12
  end
  A = math.floor(year/100)
  if not julian then
    B = 2 - A + math.floor(A/4)
  else
    B =0
  end
  JD = math.floor(365.25*(year+4716)) + 
  math.floor(30.6001*(month+1)) + Day + B - 1524.5
  return JD
end

---
-- @return JD as per wikipedia algorithm
-- 
function gregorianToJulianDay (year, month, day)
  local floor = math.floor
  local JD 
  local a = floor((14-month)/12)
  year = year + 4800 -a
  month = month + 12*a -3
  JD = day + floor((153*month+2)/5) + 365*year + floor(year/4) 
  - floor(year/100) + floor(year/400) -32045
  return JD
end  

--print('Julian Day',julianDay(2006, 8, 15.0, false))
--print(julianDay(2006, 10, 4.00, false))
--print(gregorianToJulianDay(2006, 8, 15.5))
--print(julianDay(333, 1, 27, true))
--print(julianDay(2000, 1, 1.5, false))
--print(julianDay(837, 4, 10.3, true))
--print(julianDay(-1000, 2, 29, true))

---
-- function getDaysOfMonth calculates how many
-- days are in a particular month
-- taking into account leap years
-- based on Gregorian calendar
-- @param month the month
-- @param year the year
local function getDaysOfMonth(month, year)
  local days = 31
  if month==4 or month==6 or month ==9 or month ==11 then
    days = 30
  else
    if month == 2 then 
      days = 28
      if (math.fmod(year, 4)) == 0 and (math.fmod(month,100)) ~= 0 
      and math.fmod(year,400)~=0 then -- 'leap year'
        days = 29  
      end
    end

  end  
  return days
end 


---
-- returns the day of week integer and the name of the week
-- Compatible with Lua 5.0 and 5.1.
-- from sam_lie on Lua Wiki
-- @param dd day
-- @param mm month
-- @param yy year

local function getDayOfWeek(dd, mm, yy) 
  days = m.days -- based on sunday as day =1

  local mmx = mm

  if (mm == 1) then  mmx = 13; yy = yy-1  end
  if (mm == 2) then  mmx = 14; yy = yy-1  end
  local val8 = dd + (mmx*2) +  math.floor(((mmx+1)*3)/5)  
  + yy + math.floor(yy/4)  - math.floor(yy/100)  
  + math.floor(yy/400) + 2
  local val9 = math.floor(val8/7)
  local dw = val8-(val9*7) 
  if (dw == 0) then
    dw = 7
  end
  return dw, days[dw]
end


function perpetualCalendar(mm,yy,istart,iend)
  local v = {}   -- vector to store day of month
  local j = 1
  for i= istart, iend do
    v[j] = i
    j=j+1
  end 
  return v  -- returns vector 26,27,28 etc
end

-- The main function fill a vector of 42 cells to print a 
-- Perpetual calendar. 
-- su mon tu we th fri sat
-- we need to get values both from the previous month
-- as well as the current month
-- options are for styling
-- @arg days the day object
-- 
printCalendarWeekLabel = function (days, mm, year)
  local options= m.options or {}
  local days_in_row = options.days_in_row
  local j =1
  local s1=''
  local s2='' 
  print("\\begin{scriptexample}[colback=black]{} \\raggedright\\par")
  print([[\centering\includegraphics[width=\textwidth,height=25cm,keepaspectratio]{./images/]]..m.months.images[mm]..[[}%
              \\par
              \\vspace*{3pt}%]])
  print('\\par {\\color{white}\\bfseries '..m.months[mm]..' '..year..'\\vskip3pt}')
  for i=1, days_in_row do
    if i>7 then j=i-7 end
    if j == m.options.first_day_of_week then
      s1 =[[\color{]]..m.options.first_day_of_week_color..[[}]]
      s2 =[[\color{white}]]  
    else
      s1 = [[\color{white}]] 
      s2 = ''
    end

    print('\\makebox['..options.box_width..']{\\hfill '..s1..days[j]..s2..'} %')
    j = j+1
  end  
  print("\\par")
end



function mainPerpetualCalendar (mm, yy)
  -- first we get the days in the month, as well as the 
  -- first weekday of the month
  local monthdays, dw = getDaysOfMonth(mm,yy), getDayOfWeek(1,mm,yy)
  local currentmonth = mm
  local currentyear = yy
  local previousyear = yy - 1
  local nextyear = yy + 1
  local count = 1
  if dw>1 then --print('day of week =', dw) -- we need previous month
    local previousmonth 
    if mm==1 then previousmonth = 12 -- caters for January
      previousyear = yy-1
    end
  else
    previousmonth = mm-1
    yy = currentyear
  end


  local vector = {}
  -- we use a vector to hold the 42 days in the month
  -- we need to print portion of previous month calendar

  local x1 = getDaysOfMonth(previousmonth, yy)-(dw-2) 
  local x2 = getDaysOfMonth(previousmonth, yy)

  vector = perpetualCalendar(previousmonth,yy, x1, getDaysOfMonth(previousmonth,yy)) 

  -- call for current month
  local vector2 = perpetualCalendar(currentmonth, currentyear, 1, 
    getDaysOfMonth(currentmonth, currentyear))

  for i=0, dw+monthdays  do
    vector [dw+i] = vector2[i]

  end


-- There are 42 cells in a typical calendar, so we need to get the days
-- in the following month

  local offset = 43-count -- these are from the beginning of next month

  for k,v in pairs(vector) do
    count = count+1
  end

  local z =1
  for i = count+1, 43 do
    vector[i] = z  -- at end calendar dates start 1,2,3,4
    z=z+1

  end  


  printCalendarWeekLabel(days, currentmonth, currentyear)

  count = 0
  for k,v in pairs(vector) do 
    print('\\makebox['..m.options.box_width..']{\\hfill\\color{white} '..vector[k]..'} %') 
    count = count +1
    if count == m.options.days_in_row then 
      print("\\par") 
      count = 0 
    end
  end

  print("\\end{scriptexample}\\par")
end -- close function


function easter(YR)  
--% After http://www.smart.net/~mmontes/butcher.html
  local a, b, c, d, e, f, g, h, i, k, l, m, p, EstrMnth, EstrDate
  a = YR % 19
  b = math.floor(YR/100) 
  c = YR%100
  d = math.floor(b/4) 
  e = b%4
  f = math.floor((b+8)/25) 
  g = math.floor((b-f+1)/3)
  h = (19*a+b-d-g+15) % 30
  i = math.floor(c/4) 
  k = c%4
  l = (32+2*e+2*i-h-k) % 7
  m = math.floor((a+11*h+22*l)/451) 
  EstrMnth = math.floor((h+l-7*m+114)/31)  -- // 3=March, 4=April
  print(EstrMnth)
  p = (h+l-7*m+114)%31
  EstrDate = p+1   --// date in Easter Month
  return EstrDate --+ 31*(EstrMnth-3) -- // added by JRS to return DoM

end


--print(easter(2030))

---
-- Calculate the day of the year
-- month: January = 1
-- day: 1 - 31
-- lpy: true/false
-- return: 
-- The numerical day of year

function m.calcDayOfYear(mm, dd, lpyr)
  local k, doy
  if lpyr then k = 1 else k=2 end
  doy = math.floor((275*mm)/9) - k * math.floor((mm + 9)/12) + dd -30;
  return doy
end  

---
-- 
-- @param day_of_year the day number
-- @param hour of the day
-- return fractional year in radians
function m.fractionalYear(day_of_year, hour)
  return 2*math.pi/365*(day_of_year-1 +(hour-12)/12)
end  

---
-- From $\gamma$, we estimate the equation
-- of time (in minutes) 
-- \url{http://www.esrl.noaa.gov/gmd/grad/solcalc/solareqns.PDF}
-- 
function m.equation_of_time (gamma)  
  -- return 229.18*(0.000075+0.001868*cos(gamma)-0.032077*sin(gamma) - 0.014615*cos(2*gamma)-0.040849*sin(2*gamma))
  local et, B
  B = 360 *(gamma-81)/365
  et = 9.87*sin(math.rad(2*B)) - 7.67 *sin (math.rad(B+78.7))
  return et
end  


---
-- Solar declineation in radians
-- @param gamma fractional year in radians
-- return declineation angle in radians
-- 
function m.declineation(gamma)
  return 0.006918-0.399912*math.cos(gamma) +0.070257*math.sin(gamma)-0.006758*math.cos(2*gamma)+0.000907*math.sin(2*gamma)-0.002697*math.cos(3*gamma) + 0.00148*math.sin(3*gamma)

end  

--- helper test routine
--  to print the declination for a solar year
-- 
function m.printdeclination()
  for i=1, 365,10 do  
    local delta = math.deg(m.declineation(i*math.pi/180))
    delta = string.format("%.1f", delta)
    tex.print(i, delta, ', ')
  end
end    
---
-- The time offset is used to calculate later
-- the true solar time in minutes
-- @param ET equation of time (minutes)
-- @param longitude longitude (degrees)
-- @param timezone (number)

function m.time_offset(ET, longitude, timezone)
  return ET-4*longitude+60*timezone
end  


---
-- The true solar time is calculated, using
-- @param hr hour (0-23)
-- @param min min  (0-60)
-- @param sec (0-60)
-- 
function m.true_solar_time (hr, min, sec, time_offset)
  return hr*60+min+sec/60+time_offset
end  

function m.solar_hour_angle (tst)  
  return (tst/4) - 180
end  



--
--
function m.solar_zenith(lat, decl, ha)
  local cosphi = sin(lat)*sin(decl) + cos(lat)*cos(decl)*cos(ha)
  return acos(cosphi)
end  

---
-- solar azimuth
-- 
function m.solar_azimuth(lat,decl,phi)
  local x, theta
  x = - (sin(lat)*cos(phi)-sin(decl))/(cos(lat)*sin(phi))
  x = (math.pi/180)-acos(x)
  return x
end  



--- 
-- Sunrise and sunset
-- For the special case of sunrise and sunset, the zenith
-- is set to 90.833 degrees. This is the approximate
-- correction for atmospheric refraction at sunrise, and the
-- hour angle needs to be modified

function m.hangle (lat, decl)
  local ha = (cos(90.833*math.pi/180)/(cos(lat)*cos(decl)) - tan(lat)*tan(decl))
  --ha = math.acos(.52)
  if ha<-1 or ha>1 then ha =1 
  else ha =acos(ha)
  end
  return ha
end

function m.sunrise (longitude, ha, ET)
  return 720 + 4 *(longitude) - ET
end 


---
-- \subsection{Solar noon} for any location can be found from the 
-- longitude (in degrees) and the equation of time (in minutes)
-- @param longitude (degrees)
-- @param ET equation of time (ET)
-- return solar noon in minutes
-- 
function m.solar_noon (longitude, ET)
  return 720 + 4 * longitude - ET
end  

function test_main()
  local ET = m.equation_of_time (354)
  local longitude = 10
  local latitude = 30
  local timezone = 0
  local hour = 12
  local toffset = m.time_offset(ET, longitude, timezone)
  local tst = m.true_solar_time(hour,12,1,toffset)
  local hour_angle = m.solar_hour_angle(tst)
  local decl = m.declineation(2)
  local zenith = m.solar_zenith(latitude, decl, hour_angle)
  local azimuth = m.solar_azimuth(latitude, decl, zenith)
  local h_angle = m.hangle (latitude, decl)
  local sunrise = m.sunrise(longitude, h_angle, ET)
  local solar_noon = m.solar_noon(longitude, ET)

  print('zenith = ', zenith)
  print('declination angle = ', math.deg(decl))
  print('Time offset', toffset)
  print('True solar time', tst/60)
  print('Azimuth ', math.deg(azimuth))
  print('hangle ', h_angle)
  print('sunrise', sunrise/60)
  print('solar noon ', solar_noon/60)

end



function m.equation_of_time_table (leap, nmonths)
  if nmonths==nil then nmonths =12 end
  local monthdays, s 


  if leap~=true then  
    monthdays = {31,28,31,30,31,30,31,31,30,31,30,31}
  else
    monthdays = {31,29,31,30,31,30,31,31,30,31,30,31}
  end

  local day_number, count = 0, 1
  local head = ''..
  [[\begin{longtable}{rrrrrrrrrrrrr}]]..
  [[\toprule ]]..
  [[Day &Jan  &Feb &Mar &Apr &May &Jun &Jul &Aug &Sep &Oct &Nov &Dec \\ ]]..
  [[\midrule]]
  local bottom = [[
  \bottomrule
  \end{longtable} ]]
  print (head)

  for i=1, 31 do -- number days in month
    print(i)

    for j=1, nmonths do
      if monthdays[j]>= i then
        day_number = m.calcDayOfYear(j, count, leap) 
        if m.debug == true then s ='$_{'..day_number..'}$'
        else s = '' 
        end
        print('& ' .. string.format("%.1f",(m.equation_of_time(day_number)))..s)

      else
        print('& ' ) 
        --count = count-2
      end
    end
    count = count +1
    print([[\\]])
  end  
  print(bottom)
end

--m.equation_of_time_table()
-- m.printdeclination()

m.makeCalendar = function (mm, yy)
  mainPerpetualCalendar(mm, yy)
end

m.yearCalendar = function (yy)
  for i=1, 12 do
    mainPerpetualCalendar(i, yy) 
  end
end

-- m.makeCalendar(2, 2015)
local i, n = getDayOfWeek(1,1,2007)
assert(i == 2 and n == 'Mon')
assert(getDayOfWeek(2,1,2007) == 3)
assert(getDayOfWeek(3,1,2007) == 4)
assert(getDayOfWeek(4,1,2007) == 5)
assert(getDayOfWeek(5,1,2007) == 6)
assert(getDayOfWeek(6,1,2007) == 7)
assert(getDayOfWeek(7,1,2007) == 1)
assert(getDayOfWeek(1,2,2007) == 5)


return m





