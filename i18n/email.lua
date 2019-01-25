-- load the smtp support
local smtp = require("socket.smtp")

-- Connects to server "localhost" and sends a message to users
-- "fulano@example.com",  "beltrano@example.com", 
-- and "sicrano@example.com".
-- Note that "fulano" is the primary recipient, "beltrano" receives a
-- carbon copy and neither of them knows that "sicrano" received a blind
-- carbon copy of the message.
from = "<luasocket@example.com>"

rcpt = {
  "<y.lazarides@habtoorspecon.com>",
  "<beltrano@example.com>",
  "<sicrano@example.com>"
}

mesgt = {
  headers = {
    to = "your favourite grandkid <y.lazarides@habtoorspecon.com>",
    cc = '"your favourite daughter" <yannisl@example.com>',
    subject = "from granny"
  },
  body = "I hope this works. If it does, I can send you another 1000 copies."
}

r, e = smtp.send{
  from = from,
  rcpt = rcpt, 
  source = smtp.message(mesgt)
}

--function half(x)
--  local half
--if (x % 2 ~= 0) then half= math.floor((x+1)/2)
--else half= math.ceil(x/2)
--end
--return half
--end;

--print(half(5.4))