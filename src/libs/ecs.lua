
------------------------------
-- Entity Component System
------------------------------

World = function()
 local systems = {}
 local entities = {}
 local world = {}

 function world:addEntity(entity)
   entities[#entities+1] = entity
 end

 function world:addSystem(system)
  local function match(entity)
   for _, component in pairs(system.filter) do
    if entity[component] == nil then return false end
   end
   return true
  end
  systems[#systems+1] = function(entities, ...)
   system.entities = {}
   for _, entity in pairs(entities) do
    if match(entity) then
     system.entities[#system.entities+1] = entity
    end
   end
   if system.update then system:update(...) end
   if system.process then
    for _, entity in pairs(system.entities) do
     system:process(entity, ...)
    end
   end
  end
  system.world = world
  if system.added then system:added() end
 end

 function world:update(...)
  for _, system in pairs(systems) do
   system(entities, ...)
  end
 end

 function world:removeEntity(entity)
  for i,e in pairs(entities) do
   if e == entity then
    entities[i] = nil
    break
   end
  end
 end

 function world:getEntities()
  return entities
 end

 return world
end

