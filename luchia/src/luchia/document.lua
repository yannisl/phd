--- High-level document class.
-- @author Chad Phillips
-- @copyright 2011 Chad Phillips

require "luchia.conf"
local log = require "luchia.core.log"
local server = require "luchia.core.server"
local document = require "luchia.core.document"
local attachment = require "luchia.core.attachment"
local string = require "string"

local setmetatable = setmetatable

--- High-level document class.
-- <p>Contains all of the high-level methods to manage documents and attachments.
-- This module should be used instead of the core modules when possible.
-- See the method documentation for more detail, here is a quick primer:</p>
-- <p><code>
-- -- Require the class.<br />
-- local document = require "luchia.document"<br />
-- -- Build a new document object.<br />
-- local doc = document:new("example_database")<br />
-- -- Create a new document.<br />
-- local response = doc:create({hello = "world"})<br />
-- </p></code>
module("luchia.document")


--- Create a new document handler object.
-- @param database
--   Required. The database to connect to.
-- @param server_params
--   Optional. A table of server connection parameters (identical to
--   default.server in <a href="luchia.conf.html">luchia.conf</a>). If not
--   provided, a server object will be generated from the default server
--   configuration.
-- @return A document handler object.
-- @usage doc = luchia.document:new("example_database", server_params)
function new(self, database, server_params)
  if database then
    local document = {}
    document.database = database
    document.server = server:new(server_params)
    setmetatable(document, self)
    self.__index = self
    log:debug(string.format(string.format([[New document handler to database '%s']], document.database)))
    return document
  else
    log:error([[Database name is required]])
  end
end

--- Make a document-related request to the server.
-- This is an internal method only.
-- @param method
--   Required. The HTTP method.
-- @param path
--   Required. The server path.
-- @param query_parameters
--   Optional. A table of query parameters to pass to the server, key is
--   parameter name, value is parameter value, eg.
--   '{ include_docs = "true", limit = "3" }'.
-- @param data
--   Optional. A data object.
-- @return The following four values, in this order: response_data,
--   response_code, headers, status_code.
local function document_call(self, method, path, query_parameters, data)
  if path then
    local params = {
      method = method,
      path = self.database .. "/" .. path,
      query_parameters = query_parameters,
      data = data,
    }
    local response, response_code, headers, status = self.server:request(params)
    return response, response_code, headers, status
  else
    log:error([[Path is required]])
  end
end

--- Make a document object.
-- This is an internal method only.
-- @param data
--   Optional. A table of data representing the document.
-- @param id
--   Optional. The document ID.
-- @param rev
--   Optional. The document revision.
-- @return The new document object.
local function make_document(self, data, id, rev)
  local params = {
    document = data,
    id = id,
    rev = rev,
  }
  local doc = document:new(params)
  return doc
end

--- List all documents.
-- @param query_parameters
--   Optional. Same as the document_call method.
-- @return Same values as document_call, response_data is a list of documents.
-- @usage response = doc:list()
-- @see document_call
function list(self, query_parameters)
  return document_call(self, "GET", "_all_docs", query_parameters)
end

--- Retrieve a document.
-- @param id
--   Required. The document ID.
-- @param query_parameters
--   Optional. Same as the document_call method.
-- @return Same values as document_call, response_data is a table representing
--   the document.
-- @usage response = doc:retrieve("document-id")
-- @see document_call
function retrieve(self, id, query_parameters)
  return document_call(self, "GET", id, query_parameters)
end

--- Create a document.
-- @param document
--   Optional. A table representing the document. If none is provided, an
--   empty document will be created by default.
-- @param id
--   Optional. The document ID. If not provided, a server-generated uuid will
--   be used instead.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:create({hello = "world"}, "document-id")
-- @see document_call
function create(self, document, id)
  if document then
    -- CouchDB documentation advises to not use POST if possible, instead
    -- to use PUT with a newly generated id.
    if not id then
      local uuids = self.server:uuids()
      id = uuids[1]
    end
    local doc = make_document(self, document, id)
    local query_parameters = nil
    return document_call(self, "PUT", id, query_parameters, doc)
  else
    log:error([[Document is required]])
  end
end

--- Update a document.
-- @param document
--   Required. A table representing the updated document.
-- @param id
--   Required. The document ID.
-- @param rev
--   Required. The document revision.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:update({hello = "another world"}, "document-id",
--   "1-15f65339921e497348be384867bb940f")
-- @see document_call
function update(self, document, id, rev)
  if not document then
    log:error([[document is required]])
  elseif not id then
    log:error([[id is required]])
  elseif not rev then
    log:error([[rev is required]])
  else
    local doc = make_document(self, document, id, rev)
    local query_parameters = nil
    return document_call(self, "PUT", id, query_parameters, doc)
  end
end

--- Copy a document.
-- @param id
--   Required. The document ID.
-- @param destination
--   Required. The ID of the destination document.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:copy("document-id", "document-copy")
-- @see document_call
function copy(self, id, destination)
  if not id then
    log:error([[id is required]])
  elseif not destination then
    log:error([[destination is required]])
  else
    local params = {
      method = "COPY",
      path = self.database .. "/" .. id,
      headers = {
        destination = destination
      },
    }
    local response, response_code, headers, status = self.server:request(params)
    return response, response_code, headers, status
  end
end

--- Delete a document.
-- @param id
--   Required. The document ID.
-- @param rev
--   Required. The document revision.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:delete("document-id",
--   "1-15f65339921e497348be384867bb940f")
-- @see document_call
function delete(self, id, rev)
  if not id then
    log:error([[id is required]])
  elseif not rev then
    log:error([[rev is required]])
  else
    local params = {
      rev = rev,
    }
    return document_call(self, "DELETE", id, params)
  end
end

--- Get basic information on a document.
-- This method makes a HEAD request.
-- @param id
--   Required. The document ID.
-- @return A table of the returned headers.
-- @usage response = doc:info("document-id")
function info(self, id)
  if id then
    local response, response_code, headers = document_call(self, "HEAD", id)
    -- For some reason, the etag comes back with escaped quotes, strip them
    -- out.
    headers.etag = string.gsub(headers.etag, '\"', "")
    return headers
  else
    log:error([[id is required]])
  end
end

--- Get the current revision for a document.
-- @param id
--   Required. The document ID.
-- @return The current revision.
-- @usage response = doc:current_revision("document-id")
function current_revision(self, id)
  if id then
    local headers = self:info(id)
    return headers.etag
  else
    log:error([[id is required]])
  end
end

--- Make an attachment object.
-- This is an internal method only.
-- @param file_path
--   Required. The path to the file to add as an attachment. Relative paths
--   can be used, but must have a path component, eg.
--   "./myfile" or "/tmp/attachment.txt".
-- @param content_type
--   Required. The mime content type of the attachment, eg. "text/plain"
-- @param file_name
--   Optional. The name of the attachment as stored in CouchDB. If not
--   provided, then the base name of file_path will be used.
-- @return The new attachment object.
local function make_attachment(self, file_path, content_type, file_name)
  if not file_path then
    log:error([[file_path is required]])
  elseif not content_type then
    log:error([[content_type is required]])
  else
    local params = {
      file_name = file_name,
      file_path = file_path,
      content_type = content_type,
    }
    local att = attachment:new(params)
    return att
  end
end

--- Add a standalone attachment to a document.
-- @param file_path
--   Required. Same as make_attachment.
-- @param content_type
--   Required. Same as make_attachment.
-- @param file_name
--   Optional. Same as make_attachment.
-- @param id
--   Optional. The document ID to attach the file to. If no document exists,
--   one will be created for the attachment.
-- @param rev
--   The document revision. This is only required if attaching to an existing
--   document.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:add_standalone_attachment("/tmp/file.txt",
--   "text/plain", "afile", "document-id",
--   "1-15f65339921e497348be384867bb940f")
-- @see make_attachment
-- @see document_call
function add_standalone_attachment(self, file_path, content_type, file_name, id, rev)
  local att = make_attachment(self, file_path, content_type, file_name)
  if att then
    -- Name the document the same as the attachment if none was provided.
    if not id then
      id = att.file_name
    end
    local params = {
      method = "PUT",
      path = string.format([[%s/%s/%s]], self.database, id, att.file_name),
      data = att,
    }
    if rev then
      params.query_parameters = {
        rev = rev,
      }
    end
    local response, response_code, headers, status = self.server:request(params)
    return response, response_code, headers, status
  end
end

--- Add an inline attachment to a document.
-- @param file_path
--   Required. Same as make_attachment.
-- @param content_type
--   Required. Same as make_attachment.
-- @param file_name
--   Optional. Same as make_attachment.
-- @param document
--   Optional. A table representing the document to add the attachment to. If
--   none is provided, an empty document will be used.
-- @param id
--   Optional. The document ID to attach the file to. If no document exists,
--   one will be created for the attachment.
-- @param rev
--   The document revision. This is only required if attaching to an existing
--   document.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:add_inline_attachment("/tmp/file.txt",
--   "text/plain", "afile", {hello = "world"}, "document-id",
--   "1-15f65339921e497348be384867bb940f")
-- @see make_attachment
-- @see document_call
function add_inline_attachment(self, file_path, content_type, file_name, document, id, rev)
  local att = make_attachment(self, file_path, content_type, file_name)
  if att then
    local doc = make_document(self, document, id, rev)
    if doc and doc:add_attachment(att) then
      -- Use update/create methods from this class. They expect a raw document
      -- table instead of a document object, so extract it out.
      if rev then
        return self:update(doc.document, id, rev)
      else
        return self:create(doc.document, id)
      end
    else
      log:error([[Error adding attachment]])
    end
  end
end

--- Retrieve an attachment.
-- @param attachment
--   Required. The attachment name.
-- @param id
--   Required. The document ID.
-- @return Same values as document_call, response_data is the attachment data.
-- @usage response = doc:retrieve_attachment("afile", "document-id")
-- @see document_call
function retrieve_attachment(self, attachment, id)
  if not attachment then
    log:error([[attachment is required]])
  elseif not id then
    log:error([[id is required]])
  else
    local params = {
      path = string.format([[%s/%s/%s]], self.database, id, attachment),
      -- Attachments don't come back as JSON, so prevent the automatic
      -- parsing.
      parse_json_response = false,
    }
    local response, response_code, headers, status = self.server:request(params)
    return response, response_code, headers, status
  end
end

--- Delete an attachment.
-- @param attachment
--   Required. The attachment name.
-- @param id
--   Required. The document ID.
-- @param rev
--   Required. The document revision.
-- @return Same values as document_call, response_data is a table of the
--   request result.
-- @usage response = doc:delete_attachment("afile", "document-id",
--   "1-15f65339921e497348be384867bb940f")
-- @see document_call
function delete_attachment(self, attachment, id, rev)
  if not attachment then
    log:error([[attachment is required]])
  elseif not id then
    log:error([[id is required]])
  elseif not rev then
    log:error([[rev is required]])
  else
    local path = string.format([[%s/%s]], id, attachment)
    local params = {
      rev = rev,
    }
    return document_call(self, "DELETE", path, params)
  end
end

--- Check the response for success.
-- A convenience method to ensure a successful request.
-- @param response
--   Required. The response object returned from the server request.
-- @return true if the server responsed with an ok:true, false otherwise.
-- @usage operation_succeeded = doc:response_ok(response)
function response_ok(self, response)
  return self.server:response_ok(response)
end

