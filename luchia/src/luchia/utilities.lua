--- High-level utilities class.
-- @author Chad Phillips
-- @copyright 2011 Chad Phillips

require "luchia.conf"
local log = require "luchia.core.log"
local server = require "luchia.core.server"
local string = require "string"

local setmetatable = setmetatable

--- High-level utilities class.
-- <p>Contains all high-level utility methods. This module should be used instead
-- of the core modules when possible.
-- See the method documentation for more detail, here is a quick primer:</p>
-- <p><code>
-- -- Require the class.<br />
-- local utilities = require "luchia.utilities"<br />
-- -- Build a new utilities object.<br />
-- local util = utilities:new()<br />
-- -- Grab server version.<br />
-- local response = util:version()<br />
-- </p></code>
module("luchia.utilities")

--- Create a new utilities handler object.
-- @param server_params
--   Optional. A table of server connection parameters (identical to
--   default.server in <a href="luchia.conf.html">luchia.conf</a>). If not
--   provided, a server object will be generated from the default server
--   configuration.
-- @return A utilities handler object.
-- @usage util = luchia.utilities:new(server_params)
function new(self, server_params)
  local utilities = {}
  utilities.server = server:new(server_params)
  setmetatable(utilities, self)
  self.__index = self
  log:debug(string.format([[New utilities handler]]))
  return utilities
end

--- Make a utilities-related request to the server.
-- This is an internal method only.
-- @param path
--   Optional. The server path.
-- @return The following four values, in this order: response_data,
--   response_code, headers, status_code.
local function utilities_get_call(self, path)
  local params = {
    path = path,
  }
  local response, response_code, headers, status = self.server:request(params)
  return response, response_code, headers, status
end

--- Get the database server version.
-- @return The database server version string.
-- @usage util:version()
function version(self)
  local response = utilities_get_call(self, "")
  if response and response.version then
    return response.version
  end
end

--- Get the database server configuration.
-- @return Same values as utilities_get_call, response_data is a table of
--   database server configuration information.
-- @usage util:config()
-- @see utilities_get_call
function config(self)
  return utilities_get_call(self, "_config")
end

--- Get the database server statistics.
-- @return Same values as utilities_get_call, response_data is a table of
--   database server statistics information.
-- @usage util:stats()
-- @see utilities_get_call
function stats(self)
  return utilities_get_call(self, "_stats")
end

--- Get the database server active tasks.
-- @return Same values as utilities_get_call, response_data is a list of
--   database server active tasks.
-- @usage util:active_tasks()
-- @see utilities_get_call
function active_tasks(self)
  return utilities_get_call(self, "_active_tasks")
end

