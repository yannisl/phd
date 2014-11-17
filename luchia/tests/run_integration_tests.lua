--measure code coverage, if luacov is present
pcall(require, "luacov")
require "lunatest"
require "common_test_functions"

lunatest.suite("integration.conf")
lunatest.suite("integration.database")
lunatest.suite("integration.document")
lunatest.suite("integration.utilities")

lunatest.run()

