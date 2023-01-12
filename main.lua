function love.load()
    Object = require "classic"
    require "bunny"
    require "carrot"
    carrots = {}
    initTimer = 5
    timeDecrease = initTimer-0.5
    timer = initTimer
    b1 = Bunny()
    if love.filesystem.getInfo("highScoreFile.txt") ~= nil then
        -- print(love.filesystem.read("highScoreFile.txt"))
        -- contents, size = love.filesystem.read( name, size )
        content, size = love.filesystem.read("highScoreFile.txt")
        b1.highscore = tonumber(content)

    end
end
-- test test
function love.update(dt)
    if timer >= 5 and b1.gameover == false then
        c1 = Carrot()
        table.insert(carrots, c1)
        timer = 0
    end
    timer = timer + dt
    b1:update(carrots, dt)
    crtUpdate(carrots, dt)
end

function love.draw()
    love.graphics.setBackgroundColor(135/255, 206/255, 235/255, 1)
    crtDraw(carrots)
    b1:draw(b1)
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

function love.keypressed(key)
    if key == "s" then
        b1.score = 0
        b1.gameover = false
        timer = 5
        carrots = {}
    end
end