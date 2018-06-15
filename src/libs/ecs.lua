
------------------------------
-- Entity Component System
------------------------------

World = function()
 local systems = {}
 local entities = {}
 local world = {}

 local function match(filter, entity)
  for _, component in pairs(filter) do
   if entity[component] == nil then return false end
  end
  return true
 end

 function world:addEntity(entity)
   entities[#entities+1] = entity
   for _, s in pairs(systems) do
    local system = s.system
    if match(system.filter, entity) and system.newEntity then
     system:newEntity(entity)
    end
   end
 end

 function world:addSystem(system)
  system.filter = system.filter or {}
  systems[#systems+1] = {
   update = function(entities, ...)
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
   end,
   system = system
  }
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

 function world:pick(filter)
  for _, entity in pairs(entities) do
   if match(filter, entity) then
    return entity
   end
  end
 end

 function world:update(...)
  for _, system in pairs(systems) do
   system.update(entities, ...)
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

