local common = require "luchia.tests.common"
local database = require "luchia.database"
local document = require "luchia.document"

local tests = {}
local db
local database_name
local doc

local response_code_ok = 200
local response_code_created = 201
local status_ok = "HTTP/1.1 200 OK"
local status_created = "HTTP/1.1 201 Created"

local data_key = "foo"
local data_value = "bar"
local file_path, file_data
local test_file_name = "attachment.txt"
local content_type = "text/plain"

function tests.setup()
  file_path, file_data = common.create_file1()
  database_name = "test_" .. tostring(math.random(1000000))
  db = database:new()
  local resp = db:create(database_name)
  assert_true(db:response_ok(resp), "Unable to create database")
  doc = document:new(database_name)
  assert_table(doc, "Unable to create valid document handler")
end

function tests.teardown()
  common.remove_file1()
  local resp = db:delete(database_name)
  assert_true(db:response_ok(resp), "Unable to delete database")
end

function tests.test_create_retrieve()
  local data = {
    [data_key] = data_value,
  }
  local response_data, response_code, headers, status = doc:create(data)
  assert_true(doc:response_ok(response_data), "Unable to create document")
  assert_equal(response_code_created, response_code, "Document creation response_code is incorrect")
  assert_table(headers, "headers are incorrect")
  assert_equal(status_created, status, "status is incorrect")
  local params = {
    rev = response_data.rev,
    revs = "true",
  }
  local data, code = doc:retrieve(response_data.id, params)
  assert_equal(response_data.id, data._id, "Document id mismatch")
  assert_equal(response_data.rev, data._rev, "Document rev mismatch")
  assert_equal(data_value, data[data_key], "Document data mismatch")
  assert_table(data._revisions, "revisions are missing")
  assert_equal(response_code_ok, code, "Document retrieval response_code is incorrect")
end

local function create_document()
  local resp = doc:create({[data_key] = data_value})
  assert_true(doc:response_ok(resp), "Unable to create document")
  return resp
end

function tests.test_list()
  create_document()
  local params = {
    include_docs = "true",
  }
  local data = doc:list(params)
  assert_table(data, "bad data returned from list method")
  assert_equal(1, data.total_rows, "total_rows value is incorrect")
  assert_table(data.rows[1].doc, "include_docs query_parameter failed")
end

function tests.test_update()
  local initial_doc = create_document()
  local updated_data_value = data_value .. "2"
  local data = {
    [data_key] = updated_data_value,
  }
  local updated_doc = doc:update(data, initial_doc.id, initial_doc.rev)
  assert_equal(initial_doc.id, updated_doc.id, "Document id mismatch")
  assert_not_equal(initial_doc.rev, updated_doc.rev, "Document rev was not updated")
  assert_equal(updated_data_value, data[data_key], "Document data not updated")
end

function tests.test_copy()
  local initial_doc = create_document()
  local copy_name = "copy"
  local copied_doc = doc:copy(initial_doc.id, copy_name)
  assert_equal(copy_name, copied_doc.id, "Document id mismatch")
end

function tests.test_delete()
  local initial_doc = create_document()
  local deleted_doc = doc:delete(initial_doc.id, initial_doc.rev)
  assert_true(doc:response_ok(deleted_doc), "Deletion failed")
  assert_equal(initial_doc.id, deleted_doc.id, "Document id mismatch")
  assert_not_equal(initial_doc.rev, deleted_doc.rev, "Document rev was not updated")
end

function tests.test_info()
  local initial_doc = create_document()
  local info = doc:info(initial_doc.id)
  assert_equal(initial_doc.rev, info.etag, "etag not present for info method")
end

function tests.test_current_revision()
  local initial_doc = create_document()
  local current_revision = doc:current_revision(initial_doc.id)
  assert_equal(initial_doc.rev, current_revision, "current_revision does not match")
end

function tests.test_add_inline_attachment_to_existing_document_then_retrieve()
  local initial_doc = create_document()
  local document_data, code = doc:retrieve(initial_doc.id)
  assert_equal(response_code_ok, code, "Document retrieval response_code is incorrect")
  local added_attachment = doc:add_inline_attachment(file_path, content_type, test_file_name, document_data, initial_doc.id, initial_doc.rev)
  assert_true(doc:response_ok(added_attachment), "Adding inline attachment failed")
  assert_equal(initial_doc.id, added_attachment.id, "Document id mismatch")
  assert_not_equal(initial_doc.rev, added_attachment.rev, "Document rev was not updated")
  local document_data = doc:retrieve(initial_doc.id)
  assert_equal(added_attachment.id, document_data._id, "id mismatch")
  assert_equal(added_attachment.rev, document_data._rev, "rev mismatch")
  assert_equal(data_value, document_data[data_key], "Document data mismatch")
  assert_table(document_data._attachments, "Missing _attachments key")
  assert_equal(4, common.table_length(document_data), "Bad number of keys in document")
  assert_table(document_data._attachments[test_file_name], "Missing _attachments[test_file_name] key")
  assert_equal(1, common.table_length(document_data._attachments), "Bad number of keys in document._attachments")
  local retrieved_attachment, code = doc:retrieve_attachment(test_file_name, initial_doc.id)
  assert_equal(file_data, retrieved_attachment)
  assert_equal(response_code_ok, code, "Attachment retrieval response_code is incorrect")
end

function tests.test_add_inline_attachment_to_new_document_then_retrieve()
  local added_attachment = doc:add_inline_attachment(file_path, content_type, test_file_name)
  assert_true(doc:response_ok(added_attachment), "Adding inline attachment failed")
  local document_data = doc:retrieve(added_attachment.id)
  assert_equal(added_attachment.id, document_data._id, "id mismatch")
  assert_equal(added_attachment.rev, document_data._rev, "rev mismatch")
  assert_table(document_data._attachments, "Missing _attachments key")
  assert_equal(3, common.table_length(document_data), "Bad number of keys in document")
  assert_table(document_data._attachments[test_file_name], "Missing _attachments[test_file_name] key")
  assert_equal(1, common.table_length(document_data._attachments), "Bad number of keys in document._attachments")
  local retrieved_attachment, code = doc:retrieve_attachment(test_file_name, added_attachment.id)
  assert_equal(file_data, retrieved_attachment)
  assert_equal(response_code_ok, code, "Attachment retrieval response_code is incorrect")
end

function tests.test_add_standalone_attachment_to_existing_document_then_delete_attachment()
  local initial_doc = create_document()
  local added_attachment = doc:add_standalone_attachment(file_path, content_type, test_file_name, initial_doc.id, initial_doc.rev)
  assert_true(doc:response_ok(added_attachment), "Adding standalone attachment failed")
  assert_equal(initial_doc.id, added_attachment.id, "Document id mismatch")
  assert_not_equal(initial_doc.rev, added_attachment.rev, "Document rev was not updated")
  local document_data = doc:retrieve(initial_doc.id)
  assert_equal(added_attachment.id, document_data._id, "id mismatch")
  assert_equal(added_attachment.rev, document_data._rev, "rev mismatch")
  assert_equal(data_value, document_data[data_key], "Document data mismatch")
  assert_table(document_data._attachments, "Missing _attachments key")
  assert_equal(4, common.table_length(document_data), "Bad number of keys in document")
  assert_table(document_data._attachments[test_file_name], "Missing _attachments[test_file_name] key")
  assert_equal(1, common.table_length(document_data._attachments), "Bad number of keys in document._attachments")
  local deleted_attachment = doc:delete_attachment(test_file_name, added_attachment.id, added_attachment.rev)
  assert_true(doc:response_ok(deleted_attachment), "Deleting attachment failed")
  assert_equal(initial_doc.id, deleted_attachment.id, "Document id mismatch on attachment deletion")
  assert_not_equal(added_attachment.rev, deleted_attachment.rev, "Document rev was not updated on attachment deletion")
  document_data = doc:retrieve(initial_doc.id)
  assert_equal(data_value, document_data[data_key], "Document data mismatch on attachment deletion")
  assert_not_table(document_data._attachments, "_attachments key present after attachment deletion")
  assert_equal(3, common.table_length(document_data), "Bad number of keys in document")
end

function tests.test_add_standalone_attachment_to_new_document_then_delete_attachment()
  local added_attachment = doc:add_standalone_attachment(file_path, content_type, test_file_name)
  assert_true(doc:response_ok(added_attachment), "Adding standalone attachment failed")
  local document_data = doc:retrieve(added_attachment.id)
  assert_equal(added_attachment.id, document_data._id, "id mismatch")
  assert_equal(added_attachment.rev, document_data._rev, "rev mismatch")
  assert_table(document_data._attachments, "Missing _attachments key")
  assert_equal(3, common.table_length(document_data), "Bad number of keys in document")
  assert_table(document_data._attachments[test_file_name], "Missing _attachments[test_file_name] key")
  assert_equal(1, common.table_length(document_data._attachments), "Bad number of keys in document._attachments")
  local deleted_attachment = doc:delete_attachment(test_file_name, added_attachment.id, added_attachment.rev)
  assert_true(doc:response_ok(deleted_attachment), "Deleting attachment failed")
  assert_equal(added_attachment.id, deleted_attachment.id, "Document id mismatch on attachment deletion")
  assert_not_equal(added_attachment.rev, deleted_attachment.rev, "Document rev was not updated on attachment deletion")
  document_data = doc:retrieve(added_attachment.id)
  assert_not_table(document_data._attachments, "_attachments key present after attachment deletion")
  assert_equal(2, common.table_length(document_data), "Bad number of keys in document")
end

return tests

