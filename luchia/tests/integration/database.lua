local database = require "luchia.database"

local tests = {}
local db
local database_name

function tests.setup()
 database_name = "test_" .. tostring(math.random(1000000))
 db = database:new()
 local resp = db:create(database_name)
 assert_true(db:response_ok(resp), "Unable to create database")
end

function tests.teardown()
  local resp = db:delete(database_name)
  assert_true(db:response_ok(resp), "Unable to delete database")
end

function tests.test_database_list()
  local list = db:list()
  local found_database_name = false
  for _, name in ipairs(list) do
    if name == database_name then
      found_database_name = true
      break
    end
  end
  assert_true(found_database_name, "Unable to find database name via list() method")
end

function tests.test_database_info()
  local info = db:info(database_name)
  assert_equal(database_name, info.db_name, "Unable to find database name via info() method")
end

return tests

