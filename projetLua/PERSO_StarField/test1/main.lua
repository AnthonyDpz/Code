nStars = 999
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()
starOffset = 1
Offset = 1
radius = 1
segments = 10

function love.load()
  stars = {}
  for i = 1,nStars do
    stars[i] = {}
    stars[i].x = math.random()*screenWidth
    stars[i].y = math.random()*screenHeight
  end
end
function love.update(dt)
  starOffset = (starOffset + dt) --% screenWidth
end
function love.draw()
  for i = 1,nStars do
    local thisX = (stars[i].x + Offset) % screenWidth
    local thisY = stars[i].y
    -- either draw an image:
    --love.graphics.draw(starImage,thisX,thisY)
    -- or a circle
    love.graphics.circle("fill",thisX,thisY,radius,segments)
  end
end
