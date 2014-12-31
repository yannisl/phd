local m = m or {}
---
-- Julian calendar
function julianDay (year, month, Day, julian)
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

-- @return JD as per wikipedia algorithm
-- 
function gregorianToJulianDay(year, month, day)
  local floor = math.floor
  local JD 
  local a = floor((14-month)/12)
  year = year + 4800 -a
  month = month + 12*a -3
  JD = day + floor((153*month+2)/5) + 365*year + floor(year/4) 
  - floor(year/100) + floor(year/400) -32045
  return JD
end  

print('Julian Day',julianDay(2006, 8, 15.0, false))
print(julianDay(2006, 10, 4.00, false))
print(gregorianToJulianDay(2006, 8, 15.5))
print(julianDay(333, 1, 27, true))
print(julianDay(2000, 1, 1.5, false))
print(julianDay(837, 4, 10.3, true))
print(julianDay(-1000, 2, 29, true))




--% get days in this month
--    case month of
--    value 4,6,9,11:
--        days := 30                      % Apr, Jun, Sep, Nov
--    value 2:
--        days := 28                      % Feb normal
--        if year mod 4 = 0 then
--            if not((year mod 100 = 0) and 
--                   (year mod 400 ~= 0)) then
--                days := 29              % Feb leap year
--            end if
--        end if
--    value:
--        days := 31                      % other months
--    end case  


function getDaysOfMonth(month, year)
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


-- returns the day of week integer and the name of the week
-- Compatible with Lua 5.0 and 5.1.
-- from sam_lie on Lua Wiki
function get_day_of_week(dd, mm, yy) 
  local days = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }

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


-- This is something to develop perpetual calendar
-- we have three modes
-- get from a range beginning or from end
-- get for full month
-- @arg mm the month
-- @arg yy the year
-- @offset days to insert into vector
-- @mode from beginning of the month or from end

function perpetualCalendar(mm,yy,istart,iend)
  local v = {}   -- vector to store day of month
        j = 1
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
-- 
function mainPerpetualCalendar (mm, yy)
  -- first we get the days in the month, as well as the 
  -- first weekday of the month
  local monthdays, dw = getDaysOfMonth(mm,yy), get_day_of_week(1,mm,yy)
  local C = {}
  local count = 1
  if dw>1 then print('day of week =',dw) -- we need previous month
    local previousmonth 
          if mm==1 then previousmonth = 12 -- caters for January
            yy = yy -1
          else
            previousmonth = mm-1
          end
    local vector = {}
    
    -- we need to print portion of previous month calendar
    -- we get the previous month days.
    --
    
    local x1 = getDaysOfMonth(previousmonth,yy)-(dw-2) 
    local x2 = getDaysOfMonth(previousmonth,yy)
    print('start date',x1, x2) -- start correctly
    vector = perpetualCalendar(previousmonth,yy, x1, getDaysOfMonth(previousmonth,yy)) 
  
  
  
  for k,v in pairs(vector) do print('v1', vector[k]) end
  -- will see what we need
  
  -- call for current month
  local vector2 = perpetualCalendar(mm,yy,1,getDaysOfMonth(mm,yy))
  
  
  for i=1,dw+monthdays  do
    vector [dw+i] = vector2[i]
    --print(vector[i])
  end
  
  --table.sort(vector)
  
  for k,v in pairs(vector) do 
      print("v2", vector[k]) 
      count = count +1
  end
  
  -- print('count =', count)
  
  end

-- we need to get for next month balance days
 local offset = 43-count -- these are from the beginning of next month
 local vector3 = perpetualCalendar(mm+1,yy,1,offset) 
for k,v in pairs(vector3) do 
      print("v3", vector3[k]) 
      count = count +1
  end


end  

-- print all months of the year
for i=12,12,1 do
    mainPerpetualCalendar(1,2014)
end


--local i, n = get_day_of_week(1,1,2007)
--assert(i == 2 and n == 'Mon')
--assert(get_day_of_week(2,1,2007) == 3)
--assert(get_day_of_week(3,1,2007) == 4)
--assert(get_day_of_week(4,1,2007) == 5)
--assert(get_day_of_week(5,1,2007) == 6)
--assert(get_day_of_week(6,1,2007) == 7)
--assert(get_day_of_week(7,1,2007) == 1)
--assert(get_day_of_week(1,2,2007) == 5)



return {
  julianDay            = julianDay,
  gregorianToJulianDay = gregorianToJulianDay,
  getDaysOfMonth       = getDaysOfMonth,
  get_day_of_week      = get_day_of_week
}


-- For calendar
-- determine day of week for first day

-- su  mon  tu  we  th  fr  sa 
--                   x
-- xx  xx   xx  xx   xx  xx xx




