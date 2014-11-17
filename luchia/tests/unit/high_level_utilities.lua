local common = require "luchia.tests.common"
local utilities = require "luchia.utilities"

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
  local util = utilities:new(params)
  assert_table(util, "util")
  return util
end

function tests.test_new_with_default_server_params_returns_valid_server()
  local util = new_with_default_server_params()
  assert_table(util.server, "util.server")
  assert_function(util.server.request, "util.server:request")
end

function tests.test_new_with_default_server_params_returns_only_server()
  local util = new_with_default_server_params()
  assert_equal(1, common.table_length(util), "util length")
end

local function new_with_custom_server_params()
  local util = utilities:new(conf.default.server)
  assert_table(util, "util")
  return util
end

function tests.test_new_with_custom_server_params_returns_valid_server()
  local util = new_with_custom_server_params()
  assert_table(util.server, "util.server")
  assert_function(util.server.request, "util.server:request")
end

function tests.test_new_with_custom_server_params_returns_only_server()
  local util = new_with_custom_server_params()
  assert_equal(1, common.table_length(util), "util length")
end

return tests

