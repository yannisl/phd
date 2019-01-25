---
-- Bullet graphs
--
--

-- \definecolor
-- \bulletgauge
--
--
-- 
if type(tex)=='table' then print = tex.print end


local  m = m or {} 

m.colors = {bg = 'gray'}

--- 
-- This is a method to define named colors using
-- the xcolor package. It provides more versatility
-- as only one function is required.
-- usage definecolor('tablerow','black!70')
--       definecolor('tablerow',{'rgb',120,120,120})

function m:definecolor(name, obj, basecolor)
  local s = ''  
  if type(obj) == 'string' then 
    s = [[\colorlet{]]..name..[[}{]]..obj..[[}]]
  elseif type(obj) == 'table'  then
    s = [[\definecolor{]]..name..[[}{rgb}{220}{220}{220}]]  
  end
  return print(s)
end  

---
-- defines good ranges for grays or other colors
-- follows guidelines from \url{http://www.perceptualedge.com/articles/misc/Bullet_Graph_Design_Spec.pdf}
-- @param number of ranges

function m:qualitative_range(n)
  --if n<2 then n = 2 end

  local t = { 
    {100},
    {10,35},
    {20,40,60},    
    {10,20,35,50},
    {3,10,20,35,50}
  }
  return t[n]
end

function m:define_colors(basename, range, basecolor)

  local percent
  local t = self:qualitative_range(range)

  for i = 1,range do
    m:definecolor(basename..i,'black!'..t[i],basecolor)
  end
end  



m.data = { 
  title = 'Valuation (Dec) 175.0 mil AED',
  subtitle = '',
  ranges ={200,300,500},
  marker = 200,
  bar = 100
}

function m:makecommand (options) 
  local s =[[
\renewcommand{\bulletgauge}[4][]{
    \begin{tikzpicture}[scale=0.6]
    \begin{axis}[
       width=7cm,
        y=1.5ex,
       xtick pos=left, 
        xtick = {0,50,...,400, 450},
        ytick=\empty,
        xmin=50, xmax=450,
        enlarge y limits={abs=0ex},
        tick align=outside,
        axis on top,
        every axis title/.style={
            at={(rel axis cs:0,0.5)},
            anchor=east,
            align=right,
            xshift=-0.5em
        },
        #1 
    ]
    \pgfplotsinvokeforeach{#4}{
        \pgfplotsset{cycle list name=bullet}
        \addplot +[xbar, bar width=3ex] coordinates {(##1,0)};
    }
    \addplot [fill= barcolour, xbar, bar width=1ex, ] coordinates {(#2,0)};    
    \addplot [mark=|, mark options={very thick, color=black}, mark size=1.25ex] coordinates {(#3,0)}; 
    \end{axis}
    \end{tikzpicture}]]
  ..[[}%
]]

--print('\\begin{verbatim}')
print(s)
--print('\\end{verbatim}')
end


function m:render(dat, opt)
  opt = opt or {}
  if type(opt.barcolour)~='string' then 
    opt.barcolour='black' 
  end
  
  m:define_colors('color', 5,basecolor)
  m:definecolor('barcolour',opt.barcolour)
  local s = ''
  local title,r1,r2,r3,v1,v2,title 
  if type(dat.title)~='string' then title = [[Valuation (Dec)]] 
  else
    title = dat.title
  end


  v1 =dat.bar
  --end  

  if type(dat.marker)==nil then
    v2 = 0
  else
    v2 = tostring(dat.marker)
  end  

  r1=dat.ranges[3]
  r2=dat.ranges[2]
  r3=dat.ranges[1]

  s= [[\bulletgauge[title={\bfseries{]]
      ..title
      ..[[}\\175.0  mil AED}]{]]
    ..dat.bar
    ..'}{'
    ..dat.marker
    ..[[}{]]
    ..r1
    ..','
    ..r2
    ..','
    ..r3
    ..[[}]]
  --self:makecommand()
  print([[\tikzset{barwidth/.style= {bar width=1.8ex} }]])
  print(s)
end



m:render(m.data) 



return m  




--print(example)