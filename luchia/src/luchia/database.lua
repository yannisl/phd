--- High-level database class.
-- @author Chad Phillips
-- @copyright 2011 Chad Phillips

require "luchia.conf"
local log = requires "luchia.core.log"
local server = requires "luchia.core.server"
local string = requires "string"

local setmetatable = setmetatable

--- High-level database class.
-- <p>Contains all of the high-level methods to manage databases. This module
-- should be used instead of the core modules when possible.
-- See the method documentation for more detail, here is a quick primer:</p>
-- <p><code>
-- -- Require the class.<br />
-- local database = require "luchia.database"<br />
-- -- Build a new database object.<br />
-- local db = database:new()<br />
-- -- Create a new database.<br />
-- local response = db:create("example_database")<br />
-- </p></code>
module("luchia.database")

--- Create a new database handler object.
-- @param server_params
--   Optional. A table of server connection parameters (identical to
--   default.server in <a href="luchia.conf.html">luchia.conf</a>). If not
--   provided, a server object will be generated from the default server
--   configuration.
-- @return A database handler object.
-- @usage db = luchia.database:new(server_params)
function new(self, server_params)
  local database = {}
  database.server = server:new(server_params)
  setmetatable(database, self)
  self.__index = self
  log:debug(string.format([[New database handler]]))
  return database
end

--- Make a database-related request to the server.
-- This is an internal method only.
-- @param method
--   Required. The HTTP method.
-- @param database_name
--   Required. The database name.
-- @return The following four values, in this order: response_data,
--   response_code, headers, status_code.
local function database_call(self, method, database_name)
  if database_name then
    local params = {
      method = method,
      path = database_name,
    }
    local response, response_code, headers, status = self.server:request(params)
    return response, response_code, headers, status
  else
    log:error([[Database name is required]])
  end
end

--- List all databases.
-- @return Same values as database_call, response_data is a list of databases.
-- @usage db:list()
-- @see database_call
function list(self)
  return self:info("_all_dbs")
end

--- Get information on a database.
-- @param database_name
--   Required. The database to get info from.
-- @return Same values as database_call, response_data is a table of database
--   information.
-- @usage db:info("example_database")
-- @see database_call
function info(self, database_name)
  return database_call(self, "GET", database_name)
end

--- Create a database.
-- @param database_name
--   Required. The database to create.
-- @return Same values as database_call, response_data is a table of the
--   request result.
-- @usage db:create("example_database")
-- @see database_call
function create(self, database_name)
  return database_call(self, "PUT", database_name)
end

--- Delete a database.
-- @param database_name
--   Required. The database to delete.
-- @return Same values as database_call, response_data is a table of the
--   request result.
-- @usage db:delete("example_database")
-- @see database_call
function delete(self, database_name)
  return database_call(self, "DELETE", database_name)
end

--- Check the response for success.
-- A convenience method to ensure a successful request.
-- @param response
--   Required. The response object returned from the server request.
-- @return true if the server responsed with an ok:true, false otherwise.
-- @usage operation_succeeded = db:response_ok(response)
function response_ok(self, response)
  return self.server:response_ok(response)
end

