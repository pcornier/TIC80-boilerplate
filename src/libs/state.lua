
------------------------------
-- State manager
------------------------------

State = {
 stack = {},
 index = 1
}

function State:switch(s)
 self.stack[self.index] = s
 s:enter()
end

function State:push(s)
 self.index = self.index + 1
 self.stack[self.index] = s
 s:enter()
end

function State:pop(s)
 self.stack[self.index] = nil
 self.index = self.index - 1
 s:exit()
end

function State:update(...)
 self.stack[self.index]:update(...)
end

function State:scanline(row)
  self.stack[self.index]:scanline(row)
end
