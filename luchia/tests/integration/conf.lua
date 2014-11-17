local common = require "luchia.tests.common"
local conf = require "luchia.conf"
local tests = {}

function tests.test_default_server_protocol()
  common.conf_valid_default_server_table()
  common.valid_server_protocol(conf.default.server.protocol, "conf.default.server.protocol,")
end

function tests.test_default_server_host()
  common.conf_valid_default_server_table()
  common.valid_server_host(conf.default.server.host, "conf.default.server.host")
end

function tests.test_default_server_port()
  common.conf_valid_default_server_table()
  common.valid_server_port(conf.default.server.port, "conf.default.server.port")
end

function tests.test_log_appender()
  common.conf_valid_log_table()
  if conf.log.appender then
    if conf.log.appender ~= "console" and conf.log.appender ~= "file" then
      fail("Expected value 'console' or 'file' - conf.log.appender", true)
    end
  end
end

function tests.test_log_level()
  common.conf_valid_log_table()
  if conf.log.level ~= "DEBUG" and conf.log.level ~= "INFO" and conf.log.level ~= "WARN" and conf.log.level ~= "ERROR" and conf.log.level ~= "FATAL" then
    fail("Expected value 'DEBUG' or 'INFO' or 'WARN' or 'ERROR' or 'FATAL' - conf.log.level", true)
  end
end

return tests

