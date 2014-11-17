--- Provides logging facilities.
-- @author Chad Phillips
-- @copyright 2011 Chad Phillips

--- Log a message at the debug level.
-- @param self
-- @param message
--   The message to log.
--   Note that for all logging methods listed, a function signature like
--   that of string.format() can be used, eg. <code>log:debug("hello world")
--   </code> and <code>log:debug("hello %s", "world")</code> are both valid
--   and will produce the same output.
-- @usage luchia.core.log:debug("debug message")
-- @class function
-- @name debug

--- Log a message at the info level.
-- @param self
-- @param message
--   The message to log.
-- @usage luchia.core.log:info("info message")
-- @class function
-- @name info

--- Log a message at the warn level.
-- @param self
-- @param message
--   The message to log.
-- @usage luchia.core.log:warn("warn message")
-- @class function
-- @name warn

--- Log a message at the error level.
-- @param self
-- @param message
--   The message to log.
-- @usage luchia.core.log:error("error message")
-- @class function
-- @name error

--- Log a message at the fatal level.
-- @param self
-- @param message
--   The message to log.
-- @usage luchia.core.log:fatal("fatal message")
-- @class function
-- @name fatal
-- yl
--require("logging")
--local conf = require "luchia.conf"
--local log = conf.log

--luchia.core = luchia.core or {}
--luchia.core.log = {}

--if log.appender == "file" then
  --require("logging.file")
  --luchia.core.log = logging.file(log.file, nil, log.format)
--else
  --require("logging.console")
  --luchia.core.log = logging.console(log.format)
--end
--luchia.core.log:setLevel(logging[log.level])

--return luchia.core.log

