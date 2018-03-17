-- affiche les traces dans la console
io.stdout:setvbuf('no')

-- deboguage pas à pas
if arg[#arg] == "-debug" then require("mobdebug").start()
end

local pad = {}
pad.x = 0
pad.y = 0 
pad.largeur = 80
pad.hauteur = 20
pad.drawMode = "fill"

local ball = {}
ball.x = 0
ball.y = 0
ball.rayon = 10
ball.colle = false
ball.drawMode = "fill"
ball.vX = 0
ball.vY = 0

local brique = {}
local niveau = {}

function Demarre()
  
  ball.colle = true
  
  niveau = {}
  
  for l=1,6 do
    niveau[l] = {}
    for c=1,15 do
      niveau[l][c] = 1
    end
  end
  
  
end

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  brique.hauteur = 25
  brique.largeur = largeur/15
  
  pad.y = hauteur - pad.hauteur
  
  --ecran de debut set a menu
  actualState = "menu"
  
  --chargement des differents ecrans
  imgMenu = love.graphics.newImage("/images/menu.jpg")
  imgGameOver = love.graphics.newImage("/images/gameOver.jpg")
  imgVictory = love.graphics.newImage("/images/victory.jpg")
  
  -- initialise le jeu
  Demarre()
  
end -- fin de function load

function love.update(dt)
  
  pad.x = love.mouse.getX()
  
  if ball.colle == true then
    ball.x = pad.x
    ball.y = pad.y - (pad.hauteur/2 + ball.rayon)
    
  else
    ball.x = ball.x + (ball.vX*dt)
    ball.y = ball.y + (ball.vY*dt)
  end
  -- collision avec une brique ?
  local c = math.floor(ball.x/brique.largeur)+1
  local l = math.floor(ball.y/brique.hauteur)+1
  
  if l >= 1 and l <= #niveau and c >= 1 and c <= 15 then
    if niveau[l][c] == 1 then
      ball.vY = 0 - ball.vY
      niveau[l][c] = 0
    end
  end
  
  -- collision avec les bords
  if ball.x > largeur then
    ball.vX = 0 - ball.vX
    ball.x = largeur
  end
  if ball.x < 0 then
      ball.vX = 0 - ball.vX
      ball.x = 0
  end
  if ball.y < 0 then
    ball.vY = 0 - ball.vY
    ball.y = 0
  end
  if ball.y > hauteur then
    -- on perd une balle
    ball.colle = true
  end
  
  -- test de collision avec le pad
  local posCollisionPadY = pad.y - (pad.hauteur/2) - ball.rayon
  if ball.y > posCollisionPadY then
    local dist = math.abs(pad.x - ball.x)
    if dist < pad.largeur/2 then
      ball.vY = 0 - ball.vY
      ball.y = posCollisionPadY
    end
  end
  
  
  
  

end -- fin de function update

function drawMenu()
  love.graphics.draw(imgMenu,0,0)
end
function drawGame()
  -- dessin du pad
  love.graphics.rectangle(pad.drawMode, pad.x - (pad.largeur/2), pad.y-(pad.hauteur/2), pad.largeur, pad.hauteur)
  -- dessin de la balle
  love.graphics.circle(ball.drawMode, ball.x, ball.y, ball.rayon)
  -- dessin des briques
  local bx,by = 0,0
  for l=1,6 do
    bx = 0
    for c=1,15 do
      if niveau[l][c] == 1 then
        --dessine une brique
        love.graphics.rectangle("fill",bx+1,by+1,brique.largeur-2,brique.hauteur-2)
      end
      bx = bx + brique.largeur
    end
    by = by + brique.hauteur
  end
  
end
function drawGameOver()
  love.graphics.draw(imgGameOver,0,0)
end


function love.draw()
  
  if actualState == "menu" then 
    drawMenu()
  end
  if actualState == "game" then
    drawGame()
  end
  if actualState == "gameOver" then
    drawGameOver()
  end
  
end -- fin de function draw

function love.keypressed(key)
  
  -- Menu key press
  if actualState == "menu" then 
    if key == "space" then
      Demarre()
      actualState = "game"
    end
    if key == "escape" then
      love.event.quit()
    end
    
  end -- end menu key press
  
  -- Game key press
  if actualState == "game" then
    if key == "escape" then
      actualState = "menu"
    end
    if key == "Right Clic" then -- TODO here
      ball.colle = false
    end
    
  end -- end game key press
  
  -- GameOver key press
  if actualState == "gameOver" then
    if key == "escape" then
      actualState = "menu"
    end
    
  end -- end GameOver key press
  
  print("debug: "..key)
  
end -- fin de function keypressed

function love.mousepressed(x, y, n)
    if ball.colle == true then
      ball.colle = false
      ball.vX = 200
      ball.vY = -200
    end
    
end

-- test la collision avec le pad
