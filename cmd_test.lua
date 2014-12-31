--- cmd_test

local cmd = require("cmd")

local csname, def = cmd.csname, cmd.def
csname('test', 'this is a test in csname')

def('test', 'this is a test')

