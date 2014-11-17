local common = require "luchia.tests.common"
local server = require "luchia.core.server"

local tests = {}

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

local bad_protocol = "ftp"
local bad_host = "www;example;com"
local bad_port_high = "70000"
local bad_port_low = "0"
local bad_port_nan = "foo"

local default_method = "GET"
local custom_method = "PUT"
local path = "example/foo"
local query_parameters = {
  include_docs = "true",
  limit = "3",
}
local query_parameter_key_1 = "include_docs"
local query_parameter_value_1 = "true"
local query_parameter_key_2 = "limit"
local query_parameter_value_2 = "3"
local query_string = "include_docs=true&limit=3"
local custom_headers = { destination = "foo" }
local custom_headers_key = "destination"
local custom_headers_value = "foo"
local custom_data = {foo = "bar"}
local custom_data_key = "foo"
local custom_data_value = "bar"

local response_code_ok = "200"
local response_code_not_found = "404"
local response_code_service_error = "error"
local status_ok = "HTTP/1.1 200 OK"
local status_not_found = "HTTP/1.1 404 Object Not Found"

local content_type = "application/json"
local json_good = '{"foo":"bar"}'
local json_good_key = "foo"
local json_good_value = "bar"
local json_bad = 'foo'

local uuid1 = "1c10da9e7736fc84bbb380fd1f002554"
local uuid2 = "1c10da9e7736fc84bbb380fd1f0026b8"

local function valid_server_table(srv)
  assert_table(srv, "srv")
  assert_table(srv.connection, "srv.connection")
  assert_equal(2, common.table_length(srv), "srv length")
end

local function bad_server_param(protocol, host, port)
  local params = {
    protocol = protocol,
    host = host,
    port = port,
  }
  local srv = server:new(params)
  assert_equal(nil, srv, "srv")
end

local function request_function(request)
  local url_string = string.format([[%s://%s:%s]], good_protocol, good_host, good_port)
  local response = 1
  local response_data = ""
  local response_code = response_code_ok
  local headers = request.headers
  local status = status_ok

  local uuids = url_string .. "/_uuids?"
  local uuids_with_count = url_string .. "/_uuids?count=2"
  local uuids_bad = url_string .. "/_uuids?count=bad"
  local service_error = url_string .. "/service-error?"
  local not_found = url_string .. "/not-found?"
  local valid_document_response = url_string .. "/valid-document?"

  if request.url == uuids then
    response_data = '{"uuids":["' .. uuid1 .. '"]}'
  elseif request.url == uuids_with_count then
    response_data = '{"uuids":["' .. uuid1 .. '","' .. uuid2 .. '"]}'
  elseif request.url == uuids_bad then
    response_data = '{}'
  elseif request.url == service_error then
    response = nil
    response_code = response_code_service_error
    headers = nil
    status = nil
    response_data = nil
  elseif request.url == not_found then
    response_code = response_code_not_found
    status = status_not_found
  elseif request.url == valid_document_response then
    response_data = json_good
  end

  if response_data then
    local source = ltn12.source.string(response_data)
    ltn12.pump.all(source, request.sink)
  end
  return response, response_code, headers, status
end

local function custom_request_server(params)
  params = params or {
    protocol = good_protocol,
    host = good_host,
    port = good_port,
  }
  params.custom_request_function = request_function
  local srv = server:new(params)
  valid_server_table(srv)
  return srv
end

local function prepare_request_data(self, server)
  server.content_type = content_type
  server.request_data = json_good
end

function tests.test_new_bad_protocol_returns_nil()
  bad_server_param(bad_protocol, good_host, good_port)
end

function tests.test_new_bad_host_returns_nil()
  bad_server_param(good_protocol, bad_host, good_port)
end

function tests.test_new_bad_port_low_returns_nil()
  bad_server_param(good_protocol, good_host, bad_port_low)
end

function tests.test_new_bad_port_high_returns_nil()
  bad_server_param(good_protocol, good_host, bad_port_high)
end

function tests.test_new_bad_port_nan_returns_nil()
  bad_server_param(good_protocol, good_host, bad_port_nan)
end

local function new_server_default_params()
  local params = {
    custom_configuration = conf,
  }
  local srv = server:new(params)
  valid_server_table(srv)
  return srv
end

function tests.test_new_default_params_returns_valid_connection_protocol()
  local srv = new_server_default_params()
  assert_equal(conf.default.server.protocol, srv.connection.protocol)
end

function tests.test_new_default_params_returns_valid_connection_host()
  local srv = new_server_default_params()
  assert_equal(conf.default.server.host, srv.connection.host)
end

function tests.test_new_default_params_returns_valid_connection_port()
  local srv = new_server_default_params()
  assert_equal(conf.default.server.port, srv.connection.port)
end

function tests.test_new_default_params_returns_valid_connection_user()
  local srv = new_server_default_params()
  assert_equal(conf.default.server.user, srv.connection.user)
end

function tests.test_new_default_params_returns_valid_connection_password()
  local srv = new_server_default_params()
  assert_equal(conf.default.server.password, srv.connection.password)
end

function tests.test_new_default_params_returns_valid_connection_table_length()
  local srv = new_server_default_params()
  assert_equal(5, common.table_length(srv.connection), "srv.connection length")
end

function tests.test_new_default_request_function_returns_default_request_function()
  local http = require "socket.http"
  local params = {
    custom_configuration = conf,
  }
  local srv = server:new(params)
  valid_server_table(srv)
  assert_equal(http.request, srv.request_function)
end

function tests.test_new_custom_request_function_returns_custom_request_function()
  local params = {
    custom_configuration = conf,
    custom_request_function = request_function,
  }
  local srv = server:new(params)
  valid_server_table(srv)
  assert_equal(request_function, srv.request_function)
end

local function new_server_all_params()
  local params = {
    protocol = good_protocol,
    host = good_host,
    port = good_port,
    user = user,
    password = password,
  }
  local srv = server:new(params)
  valid_server_table(srv)
  return srv
end

function tests.test_new_all_params_returns_valid_connection_protocol()
  local srv = new_server_all_params()
  assert_equal(good_protocol, srv.connection.protocol)
end

function tests.test_new_all_params_returns_valid_connection_host()
  local srv = new_server_all_params()
  assert_equal(good_host, srv.connection.host)
end

function tests.test_new_all_params_returns_valid_connection_port()
  local srv = new_server_all_params()
  assert_equal(good_port, srv.connection.port)
end

function tests.test_new_all_params_returns_valid_connection_user()
  local srv = new_server_all_params()
  assert_equal(user, srv.connection.user)
end

function tests.test_new_all_params_returns_valid_connection_password()
  local srv = new_server_all_params()
  assert_equal(password, srv.connection.password)
end

function tests.test_new_all_params_returns_valid_connection_table_length()
  local srv = new_server_all_params()
  assert_equal(5, common.table_length(srv.connection), "srv.connection length")
end

local function request_valid_document()
  local srv = custom_request_server()
  local params = {
    path = "valid-document",
  }
  local response_data, response_code, headers, status = srv:request(params)
  return response_data, response_code, headers, status
end

function tests.test_request_valid_document_returns_response_data()
  local response_data = request_valid_document()
  assert_table(response_data)
end

function tests.test_request_valid_document_returns_response_data_valid_key_value()
  local response_data = request_valid_document()
  assert_equal(json_good_value, response_data[json_good_key])
end

function tests.test_request_valid_document_returns_response_data_only_valid_key_value()
  local response_data = request_valid_document()
  assert_equal(1, common.table_length(response_data), "response_data length")
end

function tests.test_request_valid_document_returns_valid_response_code()
  local response_data, response_code = request_valid_document()
  assert_equal(response_code_ok, response_code)
end

function tests.test_request_valid_document_returns_headers()
  local response_data, response_code, headers = request_valid_document()
  assert_table(headers)
end

function tests.test_request_valid_document_returns_empty_headers()
  local response_data, response_code, headers = request_valid_document()
  assert_equal(0, common.table_length(headers), "headers length")
end

function tests.test_request_valid_document_returns_valid_status()
  local response_data, response_code, headers, status = request_valid_document()
  assert_equal(status_ok, status)
end

local function prepare_request_no_params()
  local srv = custom_request_server()
  srv:prepare_request()
  return srv
end

function tests.test_prepare_request_no_params_sets_default_method()
  local srv = prepare_request_no_params()
  assert_equal(default_method, srv.method)
end

function tests.test_prepare_request_no_params_sets_empty_path()
  local srv = prepare_request_no_params()
  assert_equal("", srv.path)
end

function tests.test_prepare_request_no_params_sets_query_parameters()
  local srv = prepare_request_no_params()
  assert_table(srv.query_parameters)
end

function tests.test_prepare_request_no_params_sets_empty_query_parameters()
  local srv = prepare_request_no_params()
  assert_equal(0, common.table_length(srv.query_parameters), "srv.query_parameters length")
end

function tests.test_prepare_request_no_params_sets_headers()
  local srv = prepare_request_no_params()
  assert_table(srv.headers)
end

function tests.test_prepare_request_no_params_sets_empty_headers()
  local srv = prepare_request_no_params()
  assert_equal(0, common.table_length(srv.headers), "srv.headers length")
end

function tests.test_prepare_request_no_params_sets_parse_json_response_true()
  local srv = prepare_request_no_params()
  assert_true(srv.parse_json_response)
end

function tests.test_prepare_request_no_params_sets_data_nil()
  local srv = prepare_request_no_params()
  assert_equal(nil, srv.data)
end

local function prepare_request_all_params()
  local srv = custom_request_server()
  local params = {
    method = custom_method,
    path = path,
    query_parameters = query_parameters,
    headers = custom_headers,
    parse_json_response = false,
    data = custom_data,
  }
  srv:prepare_request(params)
  return srv
end

function tests.test_prepare_request_all_params_sets_custom_method()
  local srv = prepare_request_all_params()
  assert_equal(custom_method, srv.method)
end

function tests.test_prepare_request_all_params_sets_custom_path()
  local srv = prepare_request_all_params()
  assert_equal(path, srv.path)
end

function tests.test_prepare_request_all_params_sets_query_parameters()
  local srv = prepare_request_all_params()
  assert_table(srv.query_parameters)
end

function tests.test_prepare_request_all_params_sets_custom_query_parameter_key_value_1()
  local srv = prepare_request_all_params()
  assert_equal(query_parameter_value_1, srv.query_parameters[query_parameter_key_1])
end

function tests.test_prepare_request_all_params_sets_custom_query_parameter_key_value_2()
  local srv = prepare_request_all_params()
  assert_equal(query_parameter_value_2, srv.query_parameters[query_parameter_key_2])
end

function tests.test_prepare_request_all_params_sets_two_custom_query_parameters()
  local srv = prepare_request_all_params()
  assert_equal(2, common.table_length(srv.query_parameters), "srv.query_parameters length")
end

function tests.test_prepare_request_all_params_sets_headers()
  local srv = prepare_request_all_params()
  assert_table(srv.headers)
end

function tests.test_prepare_request_all_params_sets_custom_header_key_value()
  local srv = prepare_request_all_params()
  assert_equal(custom_header_value, srv.headers[custom_header_key])
end

function tests.test_prepare_request_all_params_sets_one_header()
  local srv = prepare_request_all_params()
  assert_equal(1, common.table_length(srv.headers), "srv.headers length")
end

function tests.test_prepare_request_all_params_sets_parse_json_response_false()
  local srv = prepare_request_all_params()
  assert_false(srv.parse_json_response)
end

function tests.test_prepare_request_all_params_sets_data()
  local srv = prepare_request_all_params()
  assert_table(srv.data)
end

function tests.test_prepare_request_all_params_sets_custom_data_key_value()
  local srv = prepare_request_all_params()
  assert_equal(custom_data_value, srv.data[custom_data_key])
end

function tests.test_prepare_request_all_params_sets_one_custom_data_key_value()
  local srv = prepare_request_all_params()
  assert_equal(1, common.table_length(srv.data), "srv.data length")
end

function tests.test_prepare_request_data_no_content_type_resets_content_type()
  local srv = custom_request_server()
  srv.content_type = content_type
  srv:prepare_request_data()
  assert_equal(nil, srv.content_type)
end

function tests.test_prepare_request_data_no_data_resets_request_data()
  local srv = custom_request_server()
  srv.request_data = request_data
  srv:prepare_request_data()
  assert_equal(nil, srv.request_data)
end

function tests.test_prepare_request_data_set_content_type_sets_content_type()
  local srv = custom_request_server()
  local params = {
    data = {
      prepare_request_data = prepare_request_data,
    },
  }
  srv:prepare_request(params)
  srv:prepare_request_data()
  assert_equal(content_type, srv.content_type)
end

function tests.test_prepare_request_data_set_request_data_sets_server_request_data()
  local srv = custom_request_server()
  local params = {
    data = {
      prepare_request_data = prepare_request_data,
    },
  }
  srv:prepare_request(params)
  srv:prepare_request_data()
  assert_equal(json_good, srv.request_data)
end

local function execute_request_service_error()
  local srv = custom_request_server()
  local params = {
    path = "service-error",
  }
  srv:prepare_request(params)
  local response_data, response_code, headers, status = srv:execute_request()
  return response_data, response_code, headers, status
end

function tests.test_execute_request_service_error_returns_response_data_nil()
  local response_data = execute_request_service_error()
  assert_equal(nil, response_data)
end

function tests.test_execute_request_service_error_returns_valid_response_code()
  local response_data, response_code = execute_request_service_error()
  assert_equal(response_code_service_error, response_code)
end

function tests.test_execute_request_service_error_returns_headers_nil()
  local response_data, response_code, headers = execute_request_service_error()
  assert_equal(nil, headers)
end

function tests.test_execute_request_service_error_returns_status_nil()
  local response_data, response_code, headers, status = execute_request_service_error()
  assert_equal(nil, status)
end

local function execute_request_not_found()
  local srv = custom_request_server()
  local params = {
    path = "not-found",
  }
  srv:prepare_request(params)
  local response_data, response_code, headers, status = srv:execute_request()
  return response_data, response_code, headers, status
end

function tests.test_execute_request_not_found_returns_response_data_nil()
  local response_data = execute_request_not_found()
  assert_equal(nil, response_data)
end

function tests.test_execute_request_not_found_returns_valid_response_code()
  local response_data, response_code = execute_request_not_found()
  assert_equal(response_code_not_found, response_code)
end

function tests.test_execute_request_not_found_returns_headers()
  local response_data, response_code, headers = execute_request_not_found()
  assert_table(headers)
end

function tests.test_execute_request_not_found_returns_empty_headers()
  local response_data, response_code, headers = execute_request_not_found()
  assert_equal(0, common.table_length(headers), "headers length")
end

function tests.test_execute_request_not_found_returns_valid_status()
  local response_data, response_code, headers, status = execute_request_not_found()
  assert_equal(status_not_found, status)
end

local function execute_request_valid_document()
  local srv = custom_request_server()
  local params = {
    path = "valid-document",
  }
  srv:prepare_request(params)
  local response_data, response_code, headers, status = srv:execute_request()
  return response_data, response_code, headers, status
end

function tests.test_execute_request_valid_document_returns_response_data()
  local response_data = execute_request_valid_document()
  assert_table(response_data)
end

function tests.test_execute_request_valid_document_returns_response_data_valid_key_value()
  local response_data = execute_request_valid_document()
  assert_equal(json_good_value, response_data[json_good_key])
end

function tests.test_execute_request_valid_document_returns_response_data_only_valid_key_value()
  local response_data = execute_request_valid_document()
  assert_equal(1, common.table_length(response_data), "response_data length")
end

function tests.test_execute_request_valid_document_returns_valid_response_code()
  local response_data, response_code = execute_request_valid_document()
  assert_equal(response_code_ok, response_code)
end

function tests.test_execute_request_valid_document_returns_headers()
  local response_data, response_code, headers = execute_request_valid_document()
  assert_table(headers)
end

function tests.test_execute_request_valid_document_returns_empty_headers()
  local response_data, response_code, headers = execute_request_valid_document()
  assert_equal(0, common.table_length(headers), "headers length")
end

function tests.test_execute_request_valid_document_returns_valid_status()
  local response_data, response_code, headers, status = execute_request_valid_document()
  assert_equal(status_ok, status)
end

local function http_request_service_error()
  local srv = custom_request_server()
  local params = {
    path = "service-error",
  }
  srv:prepare_request(params)
  local response_data, response_code, headers, status = srv:http_request()
  return response_data, response_code, headers, status
end

function tests.test_http_request_service_error_returns_response_data_nil()
  local response_data = http_request_service_error()
  assert_equal(nil, response_data)
end

function tests.test_http_request_service_error_returns_valid_response_code()
  local response_data, response_code = http_request_service_error()
  assert_equal(response_code_service_error, response_code)
end

function tests.test_http_request_service_error_returns_headers_nil()
  local response_data, response_code, headers = http_request_service_error()
  assert_equal(nil, headers)
end

function tests.test_http_request_service_error_returns_status_nil()
  local response_data, response_code, headers, status = http_request_service_error()
  assert_equal(nil, status)
end

local function http_request_valid_document_no_data()
  local srv = custom_request_server()
  local params = {
    path = "valid-document",
  }
  srv:prepare_request(params)
  local response_data, response_code, headers, status = srv:http_request()
  return response_data, response_code, headers, status
end

function tests.test_http_request_valid_document_no_data_returns_response_data_as_json()
  local response_data = http_request_valid_document_no_data()
  assert_equal(json_good, response_data)
end

function tests.test_http_request_valid_document_no_data_returns_valid_response_code()
  local response_data, response_code = http_request_valid_document_no_data()
  assert_equal(response_code_ok, response_code)
end

function tests.test_http_request_valid_document_no_data_returns_headers()
  local response_data, response_code, headers = http_request_valid_document_no_data()
  assert_table(headers)
end

function tests.test_http_request_valid_document_no_data_returns_empty_headers()
  local response_data, response_code, headers = http_request_valid_document_no_data()
  assert_equal(0, common.table_length(headers), "headers length")
end

function tests.test_http_request_valid_document_no_data_returns_valid_status()
  local response_data, response_code, headers, status = http_request_valid_document_no_data()
  assert_equal(status_ok, status)
end

local function http_request_valid_document_with_data()
  local srv = custom_request_server()
  local params = {
    path = "valid-document",
    data = {
      prepare_request_data = prepare_request_data,
    },
  }
  srv:prepare_request(params)
  srv:prepare_request_data()
  local response_data, response_code, headers, status = srv:http_request()
  return response_data, response_code, headers, status
end

function tests.test_http_request_valid_document_with_data_returns_response_data_as_json()
  local response_data = http_request_valid_document_with_data()
  -- http_request is pre-JSON parsing.
  assert_equal(json_good, response_data)
end

function tests.test_http_request_valid_document_with_data_returns_valid_response_code()
  local response_data, response_code = http_request_valid_document_with_data()
  assert_equal(response_code_ok, response_code)
end

function tests.test_http_request_valid_document_with_data_returns_headers()
  local response_data, response_code, headers = http_request_valid_document_with_data()
  assert_table(headers)
end

function tests.test_http_request_valid_document_with_data_returns_content_type_header()
  local response_data, response_code, headers = http_request_valid_document_with_data()
  assert_equal(content_type, headers["content-type"])
end

function tests.test_http_request_valid_document_with_data_returns_content_length_header()
  local response_data, response_code, headers = http_request_valid_document_with_data()
  local json_good_length = json_good:len()
  assert_equal(json_good_length, headers["content-length"])
end

function tests.test_http_request_valid_document_with_data_returns_only_content_type_content_length_headers()
  local response_data, response_code, headers = http_request_valid_document_with_data()
  assert_equal(2, common.table_length(headers), "headers length")
end

function tests.test_http_request_valid_document_with_data_returns_valid_status()
  local response_data, response_code, headers, status = http_request_valid_document_with_data()
  assert_equal(status_ok, status)
end

function tests.test_parse_response_data_with_parse_json_response_false_returns_raw_data()
  local srv = custom_request_server()
  local params = {
    parse_json_response = false,
  }
  srv:prepare_request(params)
  local data = srv:parse_response_data(json_good)
  assert_equal(json_good, data)
end

local function parse_response_data_with_no_parse_json_response_set()
  local srv = custom_request_server()
  srv:prepare_request()
  local data = srv:parse_response_data(json_good)
  return data
end

function tests.test_parse_response_data_with_no_parse_json_response_set_returns_parsed_data()
  local data = parse_response_data_with_no_parse_json_response_set()
  assert_table(data)
end

function tests.test_parse_response_data_with_no_parse_json_response_set_returns_parsed_data_with_key_value()
  local data = parse_response_data_with_no_parse_json_response_set()
  assert_equal(json_good_value, data[json_good_key])
end

function tests.test_parse_response_data_with_no_parse_json_response_set_returns_parsed_data_with_only_key_value()
  local data = parse_response_data_with_no_parse_json_response_set()
  assert_equal(1, common.table_length(data), "parsed data length")
end

local function get_parsed_json(json_string)
  local srv = custom_request_server()
  local result = srv:parse_json(json_string)
  return result
end

function tests.test_parse_json_nil_returns_nil()
  local result = get_parsed_json(nil)
  assert_equal(nil, result)
end

function tests.test_parse_json_empty_string_returns_nil()
  local result = get_parsed_json("")
  assert_equal(nil, result)
end

function tests.test_parse_json_bad_json_returns_false()
  local result = get_parsed_json(json_bad)
  assert_false(result)
end

function tests.test_parse_json_good_json_returns_result()
  local result = get_parsed_json(json_good)
  assert_table(result)
end

function tests.test_parse_json_good_json_returns_correct_key_value()
  local result = get_parsed_json(json_good)
  assert_equal(result[json_good_key], json_good_value)
end

function tests.test_parse_json_good_json_returns_one_key_value()
  local result = get_parsed_json(json_good)
  assert_equal(1, common.table_length(result))
end

function tests.test_build_url_all_valid_params_returns_full_url()
  local params = {
    protocol = good_protocol,
    host = good_host,
    port = good_port,
    user = user,
    password = password,
  }
  local srv = custom_request_server(params)
  local params = {
    path = path,
    query_parameters = query_parameters,
  }
  srv:prepare_request(params)
  local result = srv:build_url()
  local full_url = string.format([[%s://%s:%s@%s:%s/%s?%s]], good_protocol, user, password, good_host, good_port, path, query_string)
  assert_equal(full_url, result)
end

function tests.test_stringify_parameters_no_parameters_returns_empty_string()
  local srv = custom_request_server()
  local result = srv:stringify_parameters()
  assert_equal("", result)
end

function tests.test_stringify_parameters_with_server_attribute_returns_stringified_server_attribute()
  local srv = custom_request_server()
  local params = {
    query_parameters = query_parameters,
  }
  srv:prepare_request(params)
  local result = srv:stringify_parameters()
  assert_equal(query_string, result)
end

function tests.test_stringify_parameters_with_argument_returns_stringified_argument()
  local srv = custom_request_server()
  local result = srv:stringify_parameters(query_parameters)
  assert_equal(query_string, result)
end

local function get_uuids(count)
  local srv = custom_request_server()
  local result = srv:uuids(count)
  return result
end

function tests.test_uuids_no_param_returns_result()
  local result = get_uuids()
  assert_table(result)
end

function tests.test_uuids_no_param_returns_one_uuid()
  local result = get_uuids()
  assert_equal(1, #result)
end

function tests.test_uuids_no_param_returns_valid_uuid()
  local result = get_uuids()
  assert_equal(uuid1, result[1])
end

function tests.test_uuids_count_2_returns_result()
  local result = get_uuids(2)
  assert_table(result)
end

function tests.test_uuids_count_2_returns_2_uuids()
  local result = get_uuids(2)
  assert_equal(2, #result)
end

function tests.test_uuids_count_2_returns_valid_uuid1()
  local result = get_uuids(2)
  assert_equal(uuid1, result[1])
end

function tests.test_uuids_count_2_returns_valid_uuid2()
  local result = get_uuids(2)
  assert_equal(uuid2, result[2])
end

function tests.test_uuids_count_non_numeric_returns_nil()
  local result = get_uuids("string")
  assert_equal(nil, result)
end

local function get_response_ok(response)
  local srv = custom_request_server()
  local result = srv:response_ok(response)
  return result
end

function tests.test_response_ok_true_returns_true()
  local result = get_response_ok({ok = true})
  assert_true(result)
end

function tests.test_response_ok_false_returns_false()
  local result = get_response_ok({ok = false})
  assert_false(result)
end

function tests.test_response_ok_empty_returns_nil()
  local result = get_response_ok({})
  assert_equal(nil, result)
end

function tests.test_response_ok_nil_returns_nil()
  local result = get_response_ok(nil)
  assert_equal(nil, result)
end

return tests

