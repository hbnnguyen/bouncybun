Bunny = Object:extend()

function Bunny:new()
    self.bun = love.graphics.newImage("bun.png")
    self.width = 50
    self.height = 50
    self.ground = love.graphics.getHeight()/5*4 - self.height
    self.x = love.graphics.getWidth()/3 - self.width/2
    self.y = self.ground
    self.accel = 15
    self.velos = 0
    self.timer = 0.9
    self.score = 0
    self.scoretime = 5
    self.gameover = false
end

function Bunny:update(carrots, dt)
    --bun jump
    self.velos = self.velos + self.accel * dt
    self.y = self.y + self.velos
    self.timer = self.timer + dt

    if self.y >= self.ground then
        self.y = self.ground
        self.velos = 0
    end
    if love.keyboard.isDown("space") and self.timer >= 0.1 and self.gameover == false then
        self.velos = -5
        self.timer = 0
    end
    
    --handle game over
    self:checkScore(carrots, dt)
    if self:checkCollision(carrots) and self.gameover == false then
        self:die(carrots)
        self.gameover = true
    end
end

function Bunny:draw()
    font = love.graphics.getFont()
    love.graphics.draw(self.bun, self.x, self.y)
    local score_y = love.graphics.getHeight() / 5
    love.graphics.printf(self.score, font, 0, score_y, love.graphics.getWidth(), "center")
end

function Bunny:checkCollision(carrots)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    for i=1, #carrots do
        local carrots_left = carrots[i].x
        local carrots_right = carrots[i].x + carrots[i].width
        local carrots_top = carrots[i].y
        local carrots_bottom = carrots[i].y + carrots[i].height

        if self_right > carrots_left
            and self_left < carrots_right
            and self_bottom > carrots_top
            and self_top < carrots_bottom then
                return true
        end
    end
    return false
end 

-- score count will only start if bunny passes the first carrot on the screen
function Bunny:checkScore(carrots, dt)
    local self_left = self.x
    local carrots_right = carrots[1].x + carrots[1].width
    if self_left >= carrots_right then
        if self.scoretime >= 5 then
            self.score = self.score + 1
            self.scoretime = 0
        end
    end
    self.scoretime = self.scoretime + dt
end

function Bunny:die(carrots)
    for i=1, #carrots do
        carrots[i].move = false
    end
end

--make bun stop moving in bunny die
--limit bun jumps
-- game over screen
-- press "space" to start over
-- put bunny in front of carrot 
-- press s to restart
