
-- Easter: Chapter 8, Date of Easter
-- package easter

--  Gregorian returns month and day of Easter in the Gregorian calendar.
function Gregorian (y) 
	a = y % 19
	b, c = y/100, math.fmod(y,100)
	d, e = b/4, b%4
	f = (b + 8) / 25
	g = (b - f + 1) / 3
	h = math.fmod((19*a + b - d - g + 15), 30)
	i, k = c/4, c%4
	l = math.fmod((32 + 2*e + 2*i - h - k), 7)
	m = (a + 11*h + 22*l) / 451
	n = h + l - 7*m + 114
	n, p = n/31, math.fmod(n,31)
	return n, p + 1
end

-- Julian returns month and day of Easter in the Julian calendar.
function Julian(y)
	a = math.fmod(y, 4)
	b = math.fmod(y, 7)
	c = math.fmod(y, 19)
	d = math.fmod((19*c + 15), 30)
	e = (2*a + 4*b - d + 34) % 7
	f = d + e + 114
	f, g = f/31, f%31
	return f, g + 1
end



function ExampleJulian() 
	-- Example value from p. 69.
	y = 2017
	m, d = Julian(y)
	print(y, ":", m, d)
	-- Output:
	-- 1243 :  12
end

function ExampleGregorian ()
  y=2017
  m,d =Gregorian(y)
  print(y, ":", m, d)
  print(math.fmod(20,8))
end  
  

ExampleJulian() 
ExampleGregorian()