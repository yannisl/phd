require "lualibs"
-- require "luasql.mysql"
-- commas (and spaces):
 function CommaSeparate(Arr)
   return table.concat(Arr, ", ")
 end
 tex.print(CommaSeparate({"a", "bc", "d"}))
 FileStr = os.tmpname()
    tex.sprint("\\string"..os.tmpname().." \\% temporary file name")
 Hnd = io.open(FileStr, "w")
 if Hnd then
   tex.sprint("Opened temporary file ", FileStr, " for writing\n")
   Hnd:write("Line 1\nLine 2\nLine 3\n")
Hnd:close()
for Str in io.lines(FileStr) do
  io.write(Str, "\n")
end
  os.remove(FileStr)
else
   io.write("Error opening ", FileStr, " for writing\n")
end
