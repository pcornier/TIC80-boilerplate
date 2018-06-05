
------------------------------
-- Main
------------------------------

timer = time()

function init()
 State:switch(game)
end

init()
function TIC()
 cls(0)
 local time = time() / 100
 State:update(time - timer)
 timer = time
end
