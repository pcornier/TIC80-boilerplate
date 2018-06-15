loadfile('../../src/libs/ecs.lua')()

local world = World()

-- can add entities

local e1 = {
  pos = { x = 10, y = 10 },
  color = 'blue'
}

local e2 = {
  pos = { x = 20, y = 10 }
}

world:addEntity(e1)
world:addEntity(e2)
assert(#world:getEntities() == 2, 'wrong number of entities')

-- can filter entities
assert(#world:filter({ 'pos' }) == 2, 'cannot filter entities')

-- can pick one entity
assert(world:pick({ 'color' }) == e1, 'cannot pick up entity')

-- can add systems, trigger added() and access world ref

local posSys = {
  filter = { 'pos' }
}

function posSys:added()
  assert(self.world == world, 'cannot access world reference')
end

function posSys:process(entity, data)
  entity.pos.x = entity.pos.x + 1
  entity.pos.y = entity.pos.y + 1
  assert(data.payload == 'ok', 'payload not received in process()')
end

function posSys:update(data)
  assert(data.payload == 'ok', 'payload not received in update()')
  assert(#self.entities == 2, 'wrong number of entities in pos system')
end

local colSys = {
  filter = { 'pos', 'color' }
}

function colSys:update()
  assert(#self.entities == 1, 'wrong number of entities in col system')
end

world:addSystem(posSys)
world:addSystem(colSys)
assert(#world:getSystems() == 2, 'wrong number of systems')


-- can trigger update() and process() on systems

world:update({ payload = 'ok' })

-- can remove entities

world:removeEntity(e1)
assert(#world:getEntities() == 1, 'wrong number of entities after deletion')
world:removeEntity(e2)
assert(#world:getEntities() == 0, 'wrong number of entities after deletion')

