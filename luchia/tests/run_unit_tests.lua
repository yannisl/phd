--measure code coverage, if luacov is present
pcall(require, "luacov")
require "lunatest"
require "common_test_functions"

lunatest.suite("unit.core_log")
lunatest.suite("unit.core_server")
lunatest.suite("unit.core_attachment")
lunatest.suite("unit.core_document")
lunatest.suite("unit.high_level_database")
lunatest.suite("unit.high_level_document")
lunatest.suite("unit.high_level_utilities")

lunatest.run()
