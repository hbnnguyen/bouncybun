function love.load()
    Object = require "classic"
    require "bunny"
    require "carrot"
    carrots = {}
    timer = 5
    b1 = Bunny()
end
-- test test
function love.update(dt)
    if timer >= 5 then
        c1 = Carrot()
        table.insert(carrots, c1)
        timer = 0
    end
    timer = timer + dt
    b1:update(carrots, dt)
    crtUpdate(carrots, dt)
end

function love.draw()
    b1:draw(b1)
    crtDraw(carrots)
end

function crtUpdate(carrots, dt)
    for i=1, #carrots do
        carrots[i]:update(dt)
    end
    --removes leftmost carrot when goes offscreen
    if #carrots >= 1 and carrots[1].x < -carrots[1].width then 
        table.remove(carrots, 1)
    end
end

function crtDraw(carrots)
    for i=1, #carrots do
        carrots[i]:draw()
    end
end