package = "Luchia"
version = "1.0.1-1"
source = {
   url = "git://github.com/thehunmonkgroup/luchia.git",
   branch = "v1.0.1",
}
description = {
  summary = "Lua API for CouchDB.",
  detailed = [[
    Luchia provides both low-level and high-level access to CouchDB
    (http://couchdb.apache.org), using an object-oriented approach.

    All of the basic operations are supported, including:
      CRUD operations on databases, documents, and attachments (both inline
        and standalone);
      uuid generation (server side);
      various utility functions.
  ]],
  homepage = "https://github.com/thehunmonkgroup/luchia",
  license = "Modified BSD",
}
dependencies = {
  "lua >= 5.1",
  "lua-cjson",
  "lualogging",
  "luasocket",
}
build = {
  type = "builtin",
  modules = {
    luchia = "src/luchia.lua",
    ["luchia.core.attachment"] = "src/luchia/core/attachment.lua",
    ["luchia.core.document"] = "src/luchia/core/document.lua",
    ["luchia.core.log"] = "src/luchia/core/log.lua",
    ["luchia.core.server"] = "src/luchia/core/server.lua",
    ["luchia.conf"] = "src/luchia/conf.lua",
    ["luchia.database"] = "src/luchia/database.lua",
    ["luchia.document"] = "src/luchia/document.lua",
    ["luchia.utilities"] = "src/luchia/utilities.lua",
  },
  install = {
    bin = {
      luchia_get = "src/luchia_get",
    },
  },
}

-- vim: set filetype=lua
