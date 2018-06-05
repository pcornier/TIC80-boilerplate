
------------------------------
-- Game state
------------------------------

game = {}

function game:enter()
 world = World()
end

function game:update(dt)
 world.update(dt)
end
