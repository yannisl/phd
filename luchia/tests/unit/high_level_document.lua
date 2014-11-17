local common = require "luchia.tests.common"
local document = require "luchia.document"

local database_name = "example"
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

function tests.test_new_no_database_returns_nil()
  local doc = document:new()
  assert_equal(nil, doc)
end

local function new_with_default_server_params()
  local params = {
    custom_configuration = conf,
  }
  local doc = document:new(database_name, params)
  assert_table(doc, "doc")
  return doc
end

function tests.test_new_with_default_server_params_returns_valid_database_name()
  local doc = new_with_default_server_params()
  assert_equal(database_name, doc.database)
end

function tests.test_new_with_default_server_params_returns_valid_server()
  local doc = new_with_default_server_params()
  assert_table(doc.server, "doc.server")
  assert_function(doc.server.request, "doc.server:request")
end

function tests.test_new_with_default_server_params_returns_only_database_and_server()
  local doc = new_with_default_server_params()
  assert_equal(2, common.table_length(doc), "doc length")
end

local function new_with_custom_server_params()
  local doc = document:new(database_name, conf.default.server)
  assert_table(doc, "doc")
  return doc
end

function tests.test_new_with_custom_server_params_returns_valid_database_name()
  local doc = new_with_custom_server_params()
  assert_equal(database_name, doc.database)
end

function tests.test_new_with_custom_server_params_returns_valid_server()
  local doc = new_with_custom_server_params()
  assert_table(doc.server, "doc.server")
  assert_function(doc.server.request, "doc.server:request")
end

function tests.test_new_with_custom_server_params_returns_only_database_and_server()
  local doc = new_with_custom_server_params()
  assert_equal(2, common.table_length(doc), "doc length")
end


return tests

