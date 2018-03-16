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

function Demarre()
  
  ball.colle = true
  
end

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  pad.y = hauteur - pad.hauteur
  
  --ecran de debut set a menu
  actualState = "menu"
  
  --chargement des differents ecrans
  imgMenu = love.graphics.newImage("/images/menu.jpg")
  imgGameOver = love.graphics.newImage("/images/gameOver.jpg")
  imgGameOver = love.graphics.newImage("/images/gameOver.jpg")
  
  -- initialise le jeu
  Demarre()
  
end -- fin de function load

function love.update(dt)
  
  
  
  pad.x = love.mouse.getX()
  
  if ball.colle == true then
    
    ball.x = pad.x
    ball.y = hauteur - (pad.hauteur + ball.rayon)
    
  end
  
  
end -- fin de function update

function menu()
  love.graphics.draw(imgMenu,0,0)
end
function game()
  -- dessin du pad
  love.graphics.rectangle(pad.drawMode, pad.x - (pad.largeur/2), pad.y, pad.largeur, pad.hauteur)
  -- dessin de la balle
  love.graphics.circle(ball.drawMode, ball.x, ball.y, ball.rayon)
end
function gameOver()
end


function love.draw()
  
  if actualState == "menu" then 
    menu()
  end
  if actualState == "game" then
    game()
  end
  if actualState == "gameOver" then
    gameOver()
  end
  
end -- fin de function draw

function love.keypressed(key)
  
  -- Menu key press
  if actualState == "menu" then 
    if key == "space" then 
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
    if key == "Right Clic" then 
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
