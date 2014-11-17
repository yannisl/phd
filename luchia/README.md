# Luchia
Lua API for CouchDB (http://couchdb.apache.org).

## Installation:

It is recommended to install the LuaRocks (http://luarocks.org) package
manager, as all required and optional dependencies are easy to install via this
method.

####  Requires
 * lua-cjson
 * lualogging
 * luasocket

#### Optional
 * stdlib (prettier output for luchia_get)
 * luadoc (to generate local documentation)
 * lunatest (to run unit tests)
 * luacov (to view unit test coverage)

With LuaRocks, simply run:

    luarocks install luchia

For manual installation, copy luchia.lua and the luchia directory from the
source directory, and put them somewhere in your Lua package path.

## Documentation

Available online at:
  http://thehunmonkgroup.github.com/luchia/modules/luchia.html

For local documentation, all documentation is inline, but is luadoc
(http://keplerproject.github.com/luadoc) compatible. To generate HTML
documentation, install luadoc, enter the source directory, then run:

    /path/to/luadoc -d doc *.lua luchia/*.lua luchia/core/*.lua

If you don't want to go this route, then at least start with the inline
documentation in luchia.lua.

## Support
The issue tracker for this project is provided to file bug reports, feature
requests, and project tasks -- support requests are not accepted via the issue
tracker. For all support-related issues, including configuration, usage, and
training, consider hiring a competent consultant.

## Unit tests

Luchia core classes have full unit test coverage. They can be run with:

    cd /path/to/luchia/tests
    lua run_unit_tests.lua -v


## Integration tests

The higher-level Luchia classes (luchia.database, luchia.document,
luchia.utilities) have a full integration test suite. To run it, make sure
that the default server settings in luchia.conf point to a valid, running
CouchDB instance with full administrative access, and run:

    cd /path/to/luchia/tests
    lua run_integration_tests.lua -v

