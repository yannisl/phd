local common = require "luchia.tests.common"
local document = require "luchia.core.document"
local attachment = require "luchia.core.attachment"

local tests = {}

local id = "id"
local rev = "rev"
local doc_key = "key"
local doc_value = "value"
local content_type = "application/json"
local text_file_content_type = "text/plain"
local attachment_file_name = "attachment.txt"

local custom_loader_file_path = "/tmp/textfile1.txt"
local custom_loader_file_data = "foo."

function tests.test_new_no_params_returns_empty_document()
  local doc = document:new()
  assert_table(doc, "doc")
  assert_equal(0, common.table_length(doc.document), "doc.document length")
end

function tests.test_new_no_params_returns_only_document()
  local doc = document:new()
  assert_equal(1, common.table_length(doc), "doc length")
end

local function document_only_id()
  local params = {
    id = id,
  }
  local doc = document:new(params)
  assert_table(doc, "doc")
  return doc, id
end

function tests.test_new_only_id_param_returns_id()
  local doc, id = document_only_id()
  assert_equal(id, doc.id)
end

function tests.test_new_only_id_param_returns_document()
  local doc = document_only_id()
  assert_table(doc.document, "doc.document")
end

function tests.test_new_only_id_param_returns_only_id_and_document()
  local doc = document_only_id()
  assert_equal(2, common.table_length(doc), "doc length")
end

function tests.test_new_only_id_param_returns_id_in_document()
  local doc, id = document_only_id()
  assert_equal(id, doc.document._id, "doc.document._id")
end

function tests.test_new_only_id_param_returns_only_id_in_document()
  local doc = document_only_id()
  assert_equal(1, common.table_length(doc.document), "doc.document length")
end

function tests.test_new_no_id_with_rev_param_returns_nil()
  local params = {
    rev = rev,
  }
  local doc = document:new(params)
  assert_equal(nil, doc)
end

local function document_only_document()
  local params = {
    document = {
      [doc_key] = doc_value,
    },
  }
  local doc = document:new(params)
  assert_table(doc, "doc")
  return doc
end

function tests.test_new_only_document_param_returns_document()
  local doc = document_only_document()
  assert_table(doc.document, "doc.document")
end

function tests.test_new_only_document_param_returns_only_document()
  local doc = document_only_document()
  assert_equal(1, common.table_length(doc), "doc length")
end

function tests.test_new_only_document_param_returns_correct_document_key_value()
  local doc = document_only_document()
  assert_equal(doc_value, doc.document[doc_key])
end

function tests.test_new_only_document_param_returns_only_correct_document_key_value()
  local doc = document_only_document()
  assert_equal(1, common.table_length(doc.document), "doc.document length")
end

local function document_all_params()
  local params = {
    id = id,
    rev = rev,
    document = {
      [doc_key] = doc_value,
    },
  }
  local doc = document:new(params)
  assert_table(doc, "doc")
  return doc
end

function tests.test_new_all_params_returns_id()
  local doc = document_all_params()
  assert_equal(id, doc.id)
end

function tests.test_new_all_params_returns_rev()
  local doc = document_all_params()
  assert_equal(rev, doc.rev)
end

function tests.test_new_all_params_returns_document()
  local doc = document_all_params()
  assert_table(doc.document, "doc.document")
end

function tests.test_new_all_params_returns_only_id_rev_document()
  local doc = document_all_params()
  assert_equal(3, common.table_length(doc), "doc length")
end

function tests.test_new_all_params_returns_id_in_document()
  local doc = document_all_params()
  assert_equal(id, doc.document._id)
end

function tests.test_new_all_params_returns_rev_in_document()
  local doc = document_all_params()
  assert_equal(rev, doc.document._rev)
end

function tests.test_new_all_params_returns_correct_document_key_value()
  local doc = document_all_params()
  assert_equal(doc_value, doc.document[doc_key])
end

function tests.test_new_all_params_returns_only_id_rev_correct_document_key_value()
  local doc = document_all_params()
  assert_equal(3, common.table_length(doc.document), "doc.document length")
end

local function custom_loader_function()
  return custom_loader_file_data
end

local function build_new_attachment()
  local params = {
    file_path = custom_loader_file_path,
    content_type = text_file_content_type,
    custom_loader_function = custom_loader_function,
    file_name = attachment_file_name,
  }
  local att = attachment:new(params)
  assert_table(att, "att")
  return att
end

local function document_with_attachment(att)
  att = att or build_new_attachment()
  local doc = document:new()
  assert_table(doc, "doc")
  local return_document = doc:add_attachment(att)
  return doc, return_document
end

function tests.test_add_attachment_valid_att_empty_document_valid_document()
  local doc = document_with_attachment()
  assert_table(doc.document, "doc.document")
end

function tests.test_add_attachment_valid_att_empty_document_only_document()
  local doc = document_with_attachment()
  assert_equal(1, common.table_length(doc), "doc length")
end

function tests.test_add_attachment_valid_att_empty_document_valid_attachments()
  local doc = document_with_attachment()
  assert_table(doc.document._attachments, "doc.document._attachments")
end

function tests.test_add_attachment_valid_att_empty_document_only_attachments()
  local doc = document_with_attachment()
  assert_equal(1, common.table_length(doc.document), "doc.document length")
end

function tests.test_add_attachment_valid_att_empty_document_valid_attachment_file_name()
  local doc = document_with_attachment()
  assert_table(doc.document._attachments[attachment_file_name], "doc.document._attachments[attachment_file_name]")
end

function tests.test_add_attachment_valid_att_empty_document_only_attachment_file_name()
  local doc = document_with_attachment()
  assert_equal(1, common.table_length(doc.document._attachments), "doc.document._attachments length")
end

function tests.test_add_attachment_valid_att_empty_document_valid_attachment_content_type()
  local doc = document_with_attachment()
  assert_equal(text_file_content_type, doc.document._attachments[attachment_file_name].content_type, "doc.document._attachments[attachment_file_name].content_type")
end

function tests.test_add_attachment_valid_att_empty_document_valid_attachment_data()
  local mime = require "mime"
  local doc = document_with_attachment()
  assert_equal(mime.b64(custom_loader_file_data), doc.document._attachments[attachment_file_name].data, "doc.document._attachments[attachment_file_name].data")
end

function tests.test_add_attachment_valid_att_empty_document_only_attachment_content_type_data()
  local doc = document_with_attachment()
  assert_equal(2, common.table_length(doc.document._attachments[attachment_file_name]), "doc.document._attachments[file_name] length")
end

function tests.test_add_attachment_valid_att_empty_document_doc_document_matches_return_document()
  local doc, return_document = document_with_attachment()
  assert_equal(doc.document, return_document)
end

function tests.test_add_attachment_invalid_att_empty_document_returns_nil_return_document()
  local doc, return_document = document_with_attachment({})
  assert_equal(nil, return_document, "return doc.document")
end

function tests.test_add_attachment_no_att_empty_document_returns_nil_return_document()
  local doc = document:new()
  local return_document = document:add_attachment()
  assert_equal(nil, return_document, "return doc.document")
end

function tests.test_core_document_prepare_request_data_content_type()
  local json = require "cjson"
  local server = {}
  local params = {
    id = id,
    rev = rev,
    document = {
      [doc_key] = doc_value,
    },
  }
  local doc = document:new(params)
  doc:prepare_request_data(server)
  assert_equal(content_type, server.content_type, "server.content_type")
end

function tests.test_core_document_prepare_request_data_request_data()
  local json = require "cjson"
  local server = {}
  local params = {
    id = id,
    rev = rev,
    document = {
      [doc_key] = doc_value,
    },
  }
  local doc = document:new(params)
  doc:prepare_request_data(server)
  assert_equal(json.encode(doc.document), server.request_data, "server.request_data")
end

return tests

