-- test.lua - test suite for findbin module.

-- a local copy of findbin to find itself ;)
-- 'findbin' -- https://github.com/davidm/lua-find-bin
package.preload.findbin_ = function()
  local M = {_TYPE='module', _NAME='findbin', _VERSION='0.1.1.20120406'}
  local script = arg and arg[0] or ''
  local bin = script:gsub('[/\\]?[^/\\]+$', '') -- remove file name
  if bin == '' then bin = '.' end
  M.bin = bin
  setmetatable(M, {__call = function(_, relpath) return bin .. relpath end})
  return M
end
package.path = require 'findbin_' '/lua/?.lua;' .. package.path



local function checkeq(a, b, e)
  if a ~= b then error(
    'not equal ['..tostring(a)..'] ['..tostring(b)..'] ['..tostring(e)..']', 2)
  end
end

checkeq(type(require 'findbin'.bin), 'string')

arg = nil; package.loaded.findbin = nil
checkeq(require 'findbin'.bin, '.')
arg = {[0] = 'foo.lua'}; package.loaded.findbin = nil
checkeq(require 'findbin'.bin, '.')
arg = {[0] = 'bar/foo.lua'}; package.loaded.findbin = nil
checkeq(require 'findbin'.bin, 'bar')
checkeq(require 'findbin' '/qux.lua', 'bar/qux.lua')

local z =print(require 'findbin')

print(require'findbin'.bin)
print 'OK'