Bunny = Object:extend()

function Bunny:new()
    self.width = 50
    self.height = 50
    self.ground = love.graphics.getHeight()/5*4 - self.height
    self.x = love.graphics.getWidth()/3 - self.width/2
    self.y = self.ground
    self.accel = 15
    self.velos = 0
    self.timer = 0.5
    self.score = 0
    scoretime = 5
end

function Bunny:update(dt)
    self.velos = self.velos + self.accel * dt
    self.y = self.y + self.velos
    self.timer = self.timer + dt

    if love.keyboard.isDown("up") and self.timer >= 0.1 then
        self.velos = -5
        self.timer = 0
    elseif self.y >= self.ground then
        self.y = self.ground
        self.velos = 0
    end
    self:checkScore(carrots, dt)
end

function Bunny:draw()
    local mode
    if self:checkCollision(carrots) then
        mode = "fill"
    else 
        mode = "line"
    end

    font = love.graphics.getFont()
    love.graphics.rectangle(mode, self.x, self.y, self.width, self.height)
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
        if scoretime >= 5 then
            self.score = self.score + 1
            scoretime = 0
        end
    end
    scoretime = scoretime + dt
end
