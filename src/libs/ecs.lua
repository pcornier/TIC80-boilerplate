
------------------------------
-- Entity Component System
------------------------------

World = function()
 local systems = {}
 local entities = {}
 local world = {}

 function match(filter, entity)
  for _, component in pairs(filter) do
   if entity[component] == nil then return false end
  end
  return true
 end

 function world:addEntity(entity)
   entities[#entities+1] = entity
 end

 function world:addSystem(system)
  systems[#systems+1] = function(entities, ...)
   system.entities = {}
   for _, entity in pairs(entities) do
    if match(system.filter, entity) then
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

 function world:filter(filter)
  matches = {}
  for _, entity in pairs(entities) do
   if match(filter, entity) then
    matches[#matches+1] = entity
   end
  end
  return matches
 end

 function world:update(...)
  for _, system in pairs(systems) do
   system(entities, ...)
  end
 end

 function world:removeEntity(entity)
  for i, e in pairs(entities) do
   if e == entity then
    table.remove(entities, i)
    break
   end
  end
 end

 function world:getEntities()
  return entities
 end

 function world:getSystems()
  return systems
 end

 return world
end

