local common = require "luchia.tests.common"
local database = require "luchia.database"

local good_protocol = "http"
local good_host = "www.example.com"
local good_port = "5984"
local user = "user"
local password = "password"
local conf = {
  default = {
    server = {
      protocol = good_protocol,
      host = good_host,
      port = good_port,
      user = user,
      password = password,
    },
  },
}

local tests = {}

local function new_with_default_server_params()
  local params = {
    custom_configuration = conf,
  }
  local db = database:new(params)
  assert_table(db, "db")
  return db
end

function tests.test_new_with_default_server_params_returns_valid_server()
  local db = new_with_default_server_params()
  assert_table(db.server, "db.server")
  assert_function(db.server.request, "db.server:request")
end

function tests.test_new_with_default_server_params_returns_only_server()
  local db = new_with_default_server_params()
  assert_equal(1, common.table_length(db), "db length")
end

local function new_with_custom_server_params()
  local db = database:new(conf.default.server)
  assert_table(db, "db")
  return db
end

function tests.test_new_with_custom_server_params_returns_valid_server()
  local db = new_with_custom_server_params()
  assert_table(db.server, "db.server")
  assert_function(db.server.request, "db.server:request")
end

function tests.test_new_with_custom_server_params_returns_only_server()
  local db = new_with_custom_server_params()
  assert_equal(1, common.table_length(db), "db length")
end

return tests

