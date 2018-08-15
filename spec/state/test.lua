loadfile('../../src/libs/state.lua')()

local currentState

state_a = {
  name = 'a'
}

state_b = {
  name = 'b'
}

function state_a:enter()
  currentState = self
end

function state_a:exit()
  currentState = 'exit'
end

function state_b:enter()
  currentState = self
end

function state_b:update()
  currentState = self
end

State:switch(state_a)
assert(currentState == state_a, 'state_a not found (switch)')

State:switch(state_b)
assert(currentState == state_b, 'state_b not found (switch)')

State:push(state_a)
assert(currentState == state_a, 'state_a not found (push)')

State:pop()
assert(currentState == 'exit', 'exit() not called (pop)')

State:update()
assert(currentState == state_b, 'update() not called')
