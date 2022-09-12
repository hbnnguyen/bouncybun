Carrot = Object:extend()

function Carrot:new()
    self.width = 55
    self.height = 150
    self.x = love.graphics.getWidth()
    self.y = love.graphics.getHeight()/5*4 - self.height
    self.move = true
end

function Carrot:update(dt)
    if self.move then
        self.x = self.x - 100 * dt
    end
end

function Carrot:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- carrots sprout from the ground