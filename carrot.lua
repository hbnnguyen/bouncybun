Carrot = Object:extend()

function Carrot:new()
    self.width = 55
    self.height = 150
    self.x = love.graphics.getWidth()
    self.y = love.graphics.getHeight()/5*4 - self.height
end

function Carrot:update(dt)
    self.x = self.x - 100 * dt
end

function Carrot:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
