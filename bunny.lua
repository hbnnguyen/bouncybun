Bunny = Object:extend()

function Bunny:new()
    self.bun = love.graphics.newImage("bun.png")
    self.width = 50
    self.height = 50
    self.ground = love.graphics.getHeight()/5*4 - self.height
    self.x = love.graphics.getWidth()/3 - self.width/2
    self.y = self.ground
    self.accel = 20
    self.velos = 0
    self.timer = 0.9
    self.score = 0
    self.scoretime = 5
    self.gameover = false
    self.jumpcount = 5
    self.highscore = 0
end

function Bunny:update(carrots, dt)
    --bun jump
    self.velos = self.velos + self.accel * dt
    self.y = self.y + self.velos
    self.timer = self.timer + dt

    if self.y >= self.ground then
        self.y = self.ground
        self.velos = 0
        self.jumpcount = 5
    end

    if love.keyboard.isDown("space") and self.timer >= 0.3 and self.gameover == false and self.jumpcount > 0 then
        self.jumpcount = self.jumpcount - 1
        self.velos = -7
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
    font = love.graphics.newFont("PressStart2P-Regular.ttf", 24)
    gameOverFont = love.graphics.newFont("PressStart2P-Regular.ttf", 42)
    love.graphics.draw(self.bun, self.x, self.y)

    local score_y = love.graphics.getHeight()/25
    love.graphics.printf(self.score, font, -love.graphics.getWidth()/25, score_y, love.graphics.getWidth(), "right")

    --indicates how many jumps the player has left
    for i=1, self.jumpcount do
        love.graphics.rectangle("fill", 15*(i-1)+5, 5, 10, 10)
    end
    -- the floor
    love.graphics.setColor(72/255, 111/255, 56/255, 1)
    love.graphics.rectangle("fill", 0, self.ground+self.height, love.graphics.getWidth(), self.ground)
    love.graphics.setColor(1, 1, 1, 1)

    -- game over screen
    if self.gameover == true then
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("GAME OVER", gameOverFont, 0, love.graphics.getHeight()/5, love.graphics.getWidth(), "center")
        love.graphics.printf("HIGH SCORE: "..self.highscore, font, 0, love.graphics.getHeight()*2/5, love.graphics.getWidth(), "center")
        love.graphics.printf("PRESS 'S' TO RESTART", font, 0, love.graphics.getHeight()*5/6, love.graphics.getWidth(), "center")
    end


    
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

    if self.score > self.highscore then
        self.highscore = self.score
        if love.filesystem.getInfo("highScoreFile.txt") == nil then
            love.filesystem.newFile("highScoreFile.txt")
            love.filesystem.write("highScoreFile.txt", tostring(self.highscore))
        else 
            love.filesystem.write("highScoreFile.txt", tostring(self.highscore))
        end
    end
end

-- scoreboard
-- jump counter 
