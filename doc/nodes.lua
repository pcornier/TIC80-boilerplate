
-- This example shows how to simulate a scene tree

require 'src.libs.ecs'

local world = World()

local tray = {
  id = 'tray',
  pos = { x = 1, y = 1 }
}

local plate = {
  id = 'plate',
  pos = { x = 0, y = 5 },
  parent = 'tray'
}

local steak = {
  id = 'steak',
  pos = { x = 0, y = 5 },
  parent = 'plate'
}

affinePos = { filter = { 'pos', 'parent' } }
function affinePos:update()
  for _,e in pairs(self.entities) do
    local p = world:get(e.parent)
    local px = p._wpos and p._wpos.x or p.pos.x
    local py = p._wpos and p._wpos.y or p.pos.y
    e._wpos = { x = e.pos.x + px, y = e.pos.y + py }
  end
end

world:addEntity(tray)
world:addEntity(plate)
world:addEntity(steak)
world:addSystem(affinePos)
world:update()

print(string.format('Tray position starts at [%s,%s]', tray.pos.x, tray.pos.y))
print(string.format('Plate local position [x,y] = [%s,%s]', plate.pos.x, plate.pos.y))
print(string.format('Plate world position [x,y] = [%s,%s]', plate._wpos.x, plate._wpos.y))
print(string.format('Steak local position [x,y] = [%s,%s]', steak.pos.x, steak.pos.y))
print(string.format('Steak world position [x,y] = [%s,%s]', steak._wpos.x, steak._wpos.y))

print("let's move the tray!")
tray.pos.x = 5
tray.pos.y = 5
world:update()

print(string.format('Tray position is now at [%s,%s]', tray.pos.x, tray.pos.y))
print(string.format('Plate local position [x,y] = [%s,%s]', plate.pos.x, plate.pos.y))
print(string.format('Plate world position [x,y] = [%s,%s]', plate._wpos.x, plate._wpos.y))
print(string.format('Steak local position [x,y] = [%s,%s]', steak.pos.x, steak.pos.y))
print(string.format('Steak world position [x,y] = [%s,%s]', steak._wpos.x, steak._wpos.y))



