-- this is copied from luatexbase.loader
if not package.searchers then
  package.searchers = package.loaders
end

local make_loader = function(path, pos,loadfunc) 
  local default_loader = package.searchers[pos]
  local loader = function(name)
    local file, msg = package.searchpath(name,path)
    if not file then 
      local msg = "\n\t[lualoder] Search failed"
      local ret = default_loader(name)
      if type(ret) == "string" then
        return msg ..ret
      elseif type(ret) == "nil" then
        return msg
      else 
        return ret
      end
    end
    local loader,err = loadfunc(file)
    if not loader then
      return "\n\t[lualoader] Loading error:\n\t"..err
    end
    return loader
  end
  package.searchers[pos] = loader
end

local binary_loader = function(file)
  local base = file:match("/([^%.]+)%.[%w]+$")
  local symbol = base:gsub("%.","_")
  return package.loadlib(file, "luaopen_"..symbol)
end

make_loader(package.path,2,loadfile)
make_loader(package.cpath,3, binary_loader)