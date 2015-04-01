--- epigraphs on top of sectioning commands
--  and sectioning commands styling
--  These epigraphs, which are more like asides
--  are normally inserted on top of section.
--    They are made of two boxes one left and
--    another at right. 
--  The LaTeX interface is 
-- 
--  \cxset{epigraph style = blockhead,
--        epigraph texti = this is some text,
--          epigraph textii = this is some other}


local m = {} or m

m.width = "0.8\\textwidth"
m.textleftcolor = 'theblue'
m.textrightcolor = 'thegrey'
m.multicols = {
  columnsepwidth = '12pt',  
  rule_color = 'thegray',
  rule_width = '2pt',
  rule_height = '',
}
m.text = {}
m.text.left = ''
m.text.right = ''


function m:setwidth(w)
  self.width = w
end

function m:set_columnsepwidth (w)
  w = tostring(w)
  self.multicols.columnsepwidth = w
end  


m:setwidth('0.7\\textwidth')



local tx = {}

--- Primitive and other commands. Although other LuaTeX based
--  programs build nodes rather than write TeX code to the output
--  it simpler if we just leverage TeX's ability. We use a hash
--  table to store the commands and later on to build methods to
--  set values also.
--  
tx.hash = {
  bgroup = [[\bgroup]], 
  egroup = [[\egroup]],
  quotation = [[\begin{quotation}]],
  quote = [[\end{quote}]],
  textbf = [[\textbf]],
  textit = [[\textit]],
  emph   = [[\emph]],
  -- region 3 of table of equivalents
  -- these are all TeX primitives
  -- 
  lineskip = [[\lineskip]],  -- interlineskip if baselineskip is infeasible
  baselineskip = [[\baselineskip]],
  parskip = [[\parskip]],
  abovedisplayskip = [[\abovedisplayskip]],
  belowdisplayskip = [[\belowdisplayskip]]
  
}  

local ltx = {}
ltx.hash = {
  nameuse = [[\@nameuse]],
  cons = [[\@cons]],
  cdr = [[\@cdr]],
  carcube = [[\@carcube]],
  makeatletter = {[[\@makeatletter]],
     [[Make control sequences accessible or inaccessible, by setting the \catcode to 11. ]]
   },
  makeatother = {[[\makeatother]],
    [[Make control sequence unavailable. (catcode 12)]]},
  -- counters
  z0 = [[\z@]], -- all from plain TeX and also in LaTeX
  one = [[\@ne]],
  mone = [[\m@one]],
  two  = [[\tw@]],
  sixteen = [[]],
  m     = [[]],
  MM    = [[]]
  
}  

--- horizontal boxes
--  @param w the width of the horizontal box
--  @return \\hbox to width{...}
function tx.hbox (w, contents)
  return '\\hbox to w {'..'}'  
end  

function tx.setlength (dimname, value)
  return [[\\]]..dimname..value..[[\relax]]
end  

function tx.environment()
  
end

--- LaTeX minipage
--  
--
--

function tx.minipage (w, h, contents, options)
  local s1,s2,s3
  s1 = [[\begin{minipage}{]]..w..[[}]]
  s2 = [[\end{minipage}]]
  s3 = s1..contents..s2
  return s3
end

function tx.group (contents)
  return [[\bgroup ]]..contents..[[\egroup ]]
end  

function tx.bgroup ()
  return [[\bgroup ]]  
end

function tx.egroup ()
  return [[\egroup ]]
end


if tex then print = tex.print
end


local content = [[\lipsum]]
print(tx.minipage('.8\\textwidth','2cm', tx.bgroup()..content..tx.egroup() ))



function nth_root(num, root)
  return num^(1/root)
end  

print('r', nth_root((49-0.5)/100,3))


function nthroot()
  
end









--[[
\hbox to \textwidth{\hfill
\begin{minipage}{.8\textwidth}
\columnseprule2pt
\def\columnseprulecolor{\color{thegray}}
\columnsep22pt
\begin{multicols}{2}
\arial
\color{theblue}
\flushright
\Large
Over the last year we\\
have continued to\\
...
...
career researchers.\\
\columnbreak
\color{thegray}

\small
\flushleft
\setlength{\baselineskip}{12pt plus 2pt minus 1pt}

We have engaged both\\
individuals and groups to\\
build a vision for our strategic\\
initiatives and our museums\\
...
...
project on the Efficiency and\\
Effectiveness of Peer Review\ \
Journals\\
\end{multicols}
\end{minipage}
}
\bigskip
\bgroup

]]

