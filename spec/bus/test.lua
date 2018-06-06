loadfile('../../src/libs/bus.lua')()

-- can register and emit

Bus:register('signal1', function(a, b)
  assert(a == 'some', 'data not received')
  assert(b == 'data', 'data not received')
end)

Bus:emit('signal1', 'some', 'data')


-- can aggregate results

Bus:register('signal2', function(a)
  return a + 1
end)

Bus:register('signal2', function(a)
  return a * 2
end)

local results = Bus:emit('signal2', 3)
assert(results[1] == 4, 'result should be equal to 3 + 1 = 4')
assert(results[2] == 6, 'result should be equal to 3 * 2 = 6')
