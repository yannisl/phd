require "run_unit_tests"
-- There doesn't seem to be any way in the lunatest API to reset the list of
-- loaded suites; clobber the cached version of the lunatest package here so
-- that the integration tests can reload the package and start with a fresh
-- suite list.
package.loaded.lunatest = nil
require "run_integration_tests"
