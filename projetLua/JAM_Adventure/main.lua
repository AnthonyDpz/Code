-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
--if arg[#arg] == "-debug" then require("mobdebug").start() end

function love.load()
  
  love.window.setTitle("Adventure!!!")
  
  screenWidth = love.graphics.getWidth() / 2
  screenHeight = love.graphics.getHeight() / 2
  
  gameState = "Menu"
  
  local RecCusto = require("rectangleCusto")
  
end

function love.update(dt)
  
  if gameState == "Menu" then
    updateMenu()
  end
  if gameState == "Game" then
    updateGame()
  end
  if gameState == "GameOver" then
    updateGameOver()
  end
  if gameState == "Victory" then
    updateVictory()
  end

end

function love.draw()
  
  if gameState == "Menu" then
    drawMenu()
  end
  if gameState == "Game" then
    drawGame()
  end
  if gameState == "GameOver" then
    drawGameOver()
  end
  if gameState == "Victory" then
    drawVictory()
  end
    
end

function love.keypressed(key)
  
  print(key)
  
  --escape pour quitter le jeu
  if (key == "escape") then
    love.event.quit(true)
  end
  
  if gameState == "Menu" then
    
  end
  if gameState == "Game" then
    
  end
  if gameState == "GameOver" then
    
  end
  if gameState == "Victory" then
    
  end
  
end
------------------------------ UPDATE ---------------------------------
function updateGame()
end
function updateGameOver()
end
function updateMenu()
end
function updateVictory()
end

------------------------------  DRAW  ---------------------------------
function drawGame()
end
function drawGameOver()
end
function drawMenu()
  love.graphics.circle("fill", 10, 10, 5)
  recCusto.drawRectangleCusto("fill", 20, 20, 100, 100)
end
function drawVictory()
end

  