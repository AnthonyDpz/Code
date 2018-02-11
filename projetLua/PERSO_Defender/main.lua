-- debut du jeu de Defender
-- commencé le 25/12/2017
Lander = {}
Lander.x = love.graphics.getWidth()/2
Lander.y = love.graphics.getHeight()/2
Lander.vX = 0
Lander.vY = 0
Lander.angle = -90
Lander.imgVaisseau = love.graphics.newImage("images/vaisseau.png")
Lander.imgThruster = love.graphics.newImage("images/thruster.png")
Lander.engineOn = false
Lander.speed = 3
Lander.carburant = 100

SCALE=3

function love.load()
  
end -- fin de la fonction load

function love.update(dt)
  
  -- application de la gravité
  -- Lander.vY = Lander.vY + (0.6*dt)
  
  -- attribution des touches
  if love.keyboard.isDown("up") then
    Lander.carburant = Lander.carburant - dt
    local angleRadian = math.rad(Lander.angle)
    local forceX = math.cos(angleRadian)*(Lander.speed*dt)
    local forceY = math.sin(angleRadian)*(Lander.speed*dt)
    Lander.vX = Lander.vX + forceX
    Lander.vY = Lander.vY + forceY
    
    Lander.engineOn = true
  end
  if love.keyboard.isDown("down") then
    --TODO
  end
  if love.keyboard.isDown("right") then
    Lander.carburant = Lander.carburant - dt/2
    Lander.angle = Lander.angle + 90*dt
  end
  if love.keyboard.isDown("left") then
    Lander.carburant = Lander.carburant - dt/2
    Lander.angle = Lander.angle - 90*dt
  end
  -- touche de reset des coordonnées du vaisseau
  if love.keyboard.isDown("space") then
    Lander.x = love.graphics.getWidth()/2
    Lander.y = love.graphics.getHeight()/2
  end
  
  -- calcul des nouvelles coordonnées
  Lander.x = Lander.x + Lander.vX
  Lander.y = Lander.y + Lander.vY
  
end -- fin de la fonction update

function love.draw()
  
  -- dessin du vaisseau
  love.graphics.draw(Lander.imgVaisseau, Lander.x, Lander.y, math.rad(Lander.angle+90), SCALE, SCALE,
    (Lander.imgVaisseau:getHeight())/2, (Lander.imgVaisseau:getWidth())/2)
  
  -- dessin du thruster quand touche up pressée
  if Lander.engineOn == true then
    love.graphics.draw(Lander.imgThruster, Lander.x, Lander.y, math.rad(Lander.angle+90), SCALE, SCALE,
      (Lander.imgThruster:getHeight())/2, (Lander.imgThruster:getWidth())/2)
    Lander.engineOn = false
  end
  
  -- debug 
  local sDebug = "Position du vaiseau en x: "..math.floor(Lander.x).." en y:"..math.floor(Lander.y)..", force vX:"..math.floor(Lander.vX)..", force vY:"..math.floor(Lander.vY)
  love.graphics.print(sDebug, 10, 7)
  
  -- UI
   local sCarburant = "Carburant du vaiseau: "..math.floor(Lander.carburant)
  love.graphics.print(sCarburant, 10, 20)
  
end -- fin de la fonction draw