-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
--if arg[#arg] == "-debug" then require("mobdebug").start() end

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two points.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

local lstSprites = {}

local theHuman = {}

local ZSTATES = {}
ZSTATES.NONE = ""
ZSTATES.WALK = "walk"
ZSTATES.ATTACK = "attack"
ZSTATES.BITE = "bite"
ZSTATES.CHANGEDIR = "change"

local imgAlert = love.graphics.newImage("images/alert.png")

function CreateZombie()
  local myZombie = CreateSprite(lstSprites, "zombie", "monster_", 2)
  myZombie.x = math.random(10, screenWidth-10)
  myZombie.y = math.random(10, (screenHeight/2)-10)
  
  myZombie.speed = math.random(5,50) / 200
  myZombie.range = math.random(10, 150)
  myZombie.target = nil
  
  myZombie.state = ZSTATES.NONE  
end

function UpdateZombie(pZombie, pEntities)
  
  if pZombie.state == nil then
    print("***** ERROR STATE NIL *****")
  end
  
  if pZombie.state == ZSTATES.NONE then
    pZombie.state = ZSTATES.CHANGEDIR
  elseif pZombie.state == ZSTATES.WALK then
    
    -- Collisions with borders
    local bCollide = false
    if pZombie.x < 0 then
      pZombie.x = 0
      bCollide = true
    end
    if pZombie.x > screenWidth then
      pZombie.x = screenWidth
      bCollide = true
    end
    if pZombie.y < 0 then
      pZombie.y = 0
      bCollide = true
    end
    if pZombie.y > screenHeight then
      pZombie.y = screenHeight
      bCollide = true
    end
    if bCollide then
      pZombie.state = ZSTATES.CHANGEDIR
    end
    
    -- Look for humans!
    local i
    for i,sprite in ipairs(pEntities) do
      if sprite.type == "human" and sprite.visible == true then
        local distance = math.dist(pZombie.x, pZombie.y, sprite.x, sprite.y)
        if distance < pZombie.range then
          pZombie.state = ZSTATES.ATTACK
          pZombie.target = sprite
        end
      end
    end
    
  elseif pZombie.state == ZSTATES.ATTACK then
    
    if pZombie.target == nil then
      pZombie.state = ZSTATES.CHANGEDIR
    elseif math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) > pZombie.range 
        and pZombie.target.type == "human" then
      pZombie.state = ZSTATES.CHANGEDIR
      print("Lost contact")
    elseif math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) < 5 
        and pZombie.target.type == "human" then
      pZombie.state = ZSTATES.BITE
      pZombie.vx = 0
      pZombie.vy = 0
    else
      -- Attack!!!
      local destX, destY
      destX = math.random(pZombie.target.x-20, pZombie.target.x+20)
      destY = math.random(pZombie.target.y-20, pZombie.target.y+20)
      local angle = math.angle(pZombie.x, pZombie.y, destX, destY)
      pZombie.vx = pZombie.speed * 2 * 60 * math.cos(angle)
      pZombie.vy = pZombie.speed * 2 * 60 * math.sin(angle)
    end
    
  elseif pZombie.state == ZSTATES.BITE then
    if math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) > 5  then
      pZombie.state = ZSTATES.ATTACK
    else
      if pZombie.target.Hurt ~= nil then
        pZombie.target.Hurt()
      end
      if pZombie.target.visible == false then
        pZombie.state = ZSTATES.CHANGEDIR
      end
    end
  
  elseif pZombie.state == ZSTATES.CHANGEDIR then
  
    local angle = math.angle(pZombie.x, pZombie.y, math.random(0,screenWidth), math.random(0, screenHeight))
    pZombie.vx = pZombie.speed * 60 * math.cos(angle)
    pZombie.vy = pZombie.speed * 60 * math.sin(angle)
    
    pZombie.state = ZSTATES.WALK

  end

end

function CreateSprite(pList, pType, psImageFile, pnFrames)
  local mySprite = {}
  mySprite.type = pType
  mySprite.visible = true
  
  mySprite.images = {}
  mySprite.currentFrame = 1
  local i
  for i=1,pnFrames do
    local fileName = "images/"..psImageFile..tostring(i)..".png"
    print("Loading frame "..fileName)
    mySprite.images[i] = love.graphics.newImage(fileName)
  end
  
  mySprite.x = 0
  mySprite.y = 0
  mySprite.vx = 0
  mySprite.vy = 0
  
  mySprite.width = mySprite.images[1]:getWidth()
  mySprite.height = mySprite.images[1]:getHeight()
  
  table.insert(pList, mySprite)
  
  return mySprite
end

function CreateHuman()
  local myHuman = {}
  myHuman = CreateSprite(lstSprites, "human", "player_", 4)
  myHuman.x = screenWidth / 2
  myHuman.y = (screenHeight / 6) * 5
  myHuman.life = 100
  myHuman.Hurt = function()
    myHuman.life = theHuman.life - 0.1
    if myHuman.life <= 0 then
      myHuman.life = 0
      myHuman.visible = false
    end
  end
  
  return myHuman
end

function love.load()
  
  love.window.setTitle("Zombie IA (c) Gamecodeur")
  
  screenWidth = love.graphics.getWidth() / 2
  screenHeight = love.graphics.getHeight() / 2
  
  theHuman = CreateHuman()
  
  local nZombie
  for nZombie=1,100 do
    CreateZombie()
  end
  
end

function love.update(dt)
  
  local i
  for i,sprite in ipairs(lstSprites) do
    sprite.currentFrame = sprite.currentFrame + 0.1 * 60 * dt
    if sprite.currentFrame >= #sprite.images + 1 then
      sprite.currentFrame = 1
    end
    -- Velocity
    sprite.x = sprite.x + sprite.vx * dt
    sprite.y = sprite.y + sprite.vy * dt
    
    if sprite.type == "zombie" then
      UpdateZombie(sprite, lstSprites)
    end
  end

  if love.keyboard.isDown("left") then
    theHuman.x = theHuman.x - 1 * 60 * dt
  end
  if love.keyboard.isDown("up") then
    theHuman.y = theHuman.y - 1 * 60 * dt
  end
  if love.keyboard.isDown("right") then
    theHuman.x = theHuman.x + 1 * 60 * dt
  end
  if love.keyboard.isDown("down") then
    theHuman.y = theHuman.y + 1 * 60 * dt
  end

end

function love.draw()
  
  love.graphics.push()
    
  love.graphics.scale(2,2)
  
  love.graphics.print("LIFE:"..tostring(math.floor(theHuman.life)), 1, 1)

  local i
  for i,sprite in ipairs(lstSprites) do
    if sprite.visible == true then
      local frame = sprite.images[math.floor(sprite.currentFrame)]
      love.graphics.draw(frame, sprite.x - sprite.width / 2 , sprite.y - sprite.height / 2)
      
      if sprite.type == "zombie" then
        if love.keyboard.isDown("d") then
          love.graphics.print(sprite.state, sprite.x - 10, sprite.y - sprite.height - 10)
        end
        if sprite.state == ZSTATES.ATTACK then
          love.graphics.draw(imgAlert,
            sprite.x - imgAlert:getWidth()/2,
            sprite.y - sprite.height - 2)
        end
      end
    end
  end
  
  love.graphics.pop()
    
end

function love.keypressed(key)
  
  print(key)
  
end
  