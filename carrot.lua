Carrot = Object:extend()

function Carrot:new()
    self.width = math.random(25,60)
    self.height = math.random(50,200)
    self.x = love.graphics.getWidth()
    self.y = love.graphics.getHeight()/5*4 - self.height
    self.move = true
end

function Carrot:draw()
    love.graphics.setColor(237/255, 145/255, 33/255, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 15)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 15)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setColor(106/255, 190/255, 48/255, 1)
    love.graphics.polygon("fill", self.x,self.y+self.height, self.x+self.width,self.y+self.height, self.x+self.width/2,self.y+self.height*3/4)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.polygon("line", self.x,self.y+self.height, self.x+self.width,self.y+self.height, self.x+self.width/2,self.y+self.height*3/4)
    love.graphics.setColor(1,1,1,1)
end

-- carrots sprout from the ground