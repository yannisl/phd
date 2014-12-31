--[[
 stringarray.lua - string with array-like interface.
 Example:
   local SA = require 'stringarray'
   local s = SA 'test'
   assert(s[3] == 's') -- access third element
   from https://github.com/davidm/lua-stringlua/blob/master/lmod/stringlua/stringarray.lua
--]]


local string_sub = string.sub

local mt = {}
function mt:__tostring() return self.s end
function mt.__eq(a,b) return a.s == b.s end
function mt:__len() return #self.s end
function mt:__substring(sb,se) return string_sub(self.s,sb,se) end
function mt:__index(i)
  return i <= #self.s and string_sub(self.s, i, i) or nil
end

local function new(s)
  assert(type(s) == 'string')
  return setmetatable({s=s}, mt)
end

s = new('test')

print(s[2])




return new