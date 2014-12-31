---
--  phdDB
--  a master record holds all dbs for a system
--  
--  We define crude operations 
--  create db
--  delete db
--  update db
--  table db holds all the tables related to one db
--  db is serialized and saved in a file with the same name
--  all crude operations are supported
--  
local dbs = dbs or {}
dbs.db = dbs.db or {}
dbs.databases = dbs.databases or {}
db = dbs.db
db.t = db.t or {}
t = db.t 
t.fields = {}

function db:create (o)
  print('TYPE o',type(tostring(o)))
  -- insert into databases at creation time
  insert(dbs.databases, 'o')
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  print('TYPE o',type(o))
  return o
end


function t:create (z)
    z = z or {}
  --z = {name = ''}   -- create object if user does not provide one
  setmetatable(z, self)
  self.__index = self
  return z
end

 

function t:add_field (field)
  table.insert(self.fields, field)  
  --table.sort(t.fields)
  self[field] = self[field] or {}
  self[field] = {name = field,
    values = {},
    meta = {}} -- create field table
end  

function t:add_fields (...)
  local args = {...}
  for k,v in pairs (args) do
    table.insert(self.fields, v)
    self[v] = self[v] or {}
    self[v] = {name = v,
      values = {},
      meta} -- create field table
  end
  --table.sort(self.fields)
end

---
-- Insert full row of table
-- 
function t:insert_row(...)
  local args = {...}
  local current = 1
  for k,v in pairs(self.fields) do
    if self[v].values then
      --print('ok')
      table.insert(self[v].values, args[current])
      print(k,v,args[current],self[v].values)
      current = current +1
    else
      --print('not ok', k,v, self[v].values)
    end 
  end
end  

---
-- Select columns to print
-- 
function t:print_table(...)
  local args = {...}
  for k,v in pairs(args) do
    if self[v] then print(v) end
  end
end


---
--
--

t:add_fields('column_a','column_b','column_c', 'column_d', 'column_e', 'column_f')
-- add some rows for testing
for i=1,6 do
  t:insert_row('a', 'b','c', 'i' , i, 'aaa')
end


for i,j in pairs(t.fields) do
  for k,v in pairs (t[j].values) do
    print (k,v)
  end  
end

--- Create a database to hold the stamp information
--
--
-- 
--db:create(stamps)

local stamps = t:create(stamps)
stamps:add_fields('id','value','condition','country','year','set')


stamps:print_table('id','value')

for k,v in pairs(dbs.databases) do
   print(k,v)
end


