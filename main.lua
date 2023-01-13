function love.load()
    Object = require "classic"
    require "bunny"
    require "carrot"
    carrots = {}
    timer = 5
    b1 = Bunny()
    speed = 100

    bgm = love.audio.newSource("bgm.mp3", "stream")
    bgm:setLooping(true)
    love.audio.setVolume(0.1)
    love.audio.play(bgm)

    if love.filesystem.getInfo("highScoreFile.txt") ~= nil then
        content, size = love.filesystem.read("highScoreFile.txt")
        b1.highscore = tonumber(content)
    end
   
end
-- test test
function love.update(dt)
    if timer >= (100/speed)*5 and b1.gameover == false then
        c1 = Carrot()
        table.insert(carrots, c1)
        timer = 0
    end
    timer = timer + dt
    b1:update(carrots, dt, speed)
    crtUpdate(carrots, dt)
    
    speed = math.min(speed+0.05, 350)
end

function love.draw()
    love.graphics.setBackgroundColor(135/255, 206/255, 235/255, 1)
    crtDraw(carrots)
    b1:draw(b1)
end

function crtUpdate(carrots, dt)
    for i=1, #carrots do
        if carrots[i].move then
            carrots[i].x = carrots[i].x - speed * dt
        end
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
        speed = 100
    end
    if key == "r" then
        b1.highscore = 0
    end
end