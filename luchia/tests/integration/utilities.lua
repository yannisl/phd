local utilities = require "luchia.utilities"

local tests = {}
local util

function tests.setup()
  util = utilities:new()
  assert_table(util, "Unable to create utilities server")
end

function tests.teardown()
  util = nil
end

function tests.test_version()
  local server = require "luchia.core.server"
  local srv = server:new()
  local info = srv:request()
  local version = util:version()
  assert_equal(info.version, version, "Unable to get matching version information")
end

function tests.test_config()
  local config = util:config()
  assert_table(config.httpd)
end

function tests.test_stats()
  local stats = util:stats()
  assert_table(stats.couchdb)
end

function tests.test_active_tasks()
  local active_tasks = util:active_tasks()
  assert_table(active_tasks)
end

return tests

