
------------------------------
-- Global event system
------------------------------

Bus = {
 reg = {}
}

function Bus:emit(event, ...)
 local res = {}
 if self.reg[event] then
  for _, cb in pairs(self.reg[event]) do
   local r = cb(...)
   if r ~= nil then table.insert(res, r) end
  end
 end
 return res
end

function Bus:register(event, cb)
 self.reg[event] = self.reg[event] or {}
 table.insert(self.reg[event], cb)
end
