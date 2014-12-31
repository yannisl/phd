-- findbin.lua -- see README
-- (c) 2011-2012 David Manura.  Licensed under Lua 5.1 terms (MIT license).

local M = {_TYPE='module', _NAME='findbin', _VERSION='0.1.1.20120406'}
local script = arg and arg[0] or ''
local bin = script:gsub('[/\\]?[^/\\]+$', '') -- remove file name
if bin == '' then bin = '.' end
M.bin = bin
setmetatable(M, {__call = function(_, relpath) return bin .. relpath end})
return M