charclasses = charclasses or {}

function setcharclass (a,b)
   charclasses[a] = b
end

local i = 0
while i < 65536 do
  charclasses[i]  = 0
  i = i + 1
end

interchartoks =  interchartoks or {}

function setinterchartoks (a,b,c)
   interchartoks[a] = interchartoks[a] or {}
   interchartoks[a][b] = c
end

local nc, oc
oc = 255

function do_intertoks ()
  local tok = token.get_next()
  if tex.count['XeTeXinterchartokenstate'] == 1 then
      if tok[1] == 11 or  tok[1] == 12 then
        nc = charclasses[tok[2]]
        newchar = tok[2]
      else
        nc = 255
        newchar = ''
      end
      local insert  = ''
      if interchartoks[oc] and interchartoks[oc][nc] then
          insert = interchartoks[oc][nc]
          local newtok = tok
          if insert<100 then
            local dec = math.floor(insert / 10) + 48;
            local unit = math.floor(insert % 10) + 48;
            newtok = {
              -- \XeTeXinterchartokenstate=0 \the\toks<n> \XeTeXinterchartokenstate=1
              token.create('XeTeXinterchartokenstate'),
              token.create(string.byte('='),12),
              token.create(string.byte('0'),12),
              token.create(string.byte(' '),10),
              token.create('the'),
              token.create('toks'),
              token.create(dec,12),
              token.create(unit,12),
              token.create(string.byte(' '),10),
              token.create('XeTeXinterchartokenstate'),
              token.create(string.byte('='),12),
              token.create(string.byte('1'),12),
              token.create(string.byte(' '),10),
              {tok[1], tok[2], tok[3]}}
          end
          tok = newtok
      end
      oc = nc
  end
  return tok
end

callback.register ('token_filter', do_intertoks)
