-- affiche les traces dans la console
io.stdout:setvbuf('no')

-- deboguage pas à pas
if arg[#arg] == "-debug" then
  require("mobdebug").start()
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
  
end -- fin de function load

function love.update(dt)
  
  Demarre()
  
  pad.x = love.mouse.getX()
  
  if ball.colle == true then
    
    ball.x = pad.x
    ball.y = hauteur - (pad.hauteur + ball.rayon)
    
  end
  
  
end -- fin de function update

function love.draw()
  
  -- dessin du pad
  love.graphics.rectangle(pad.drawMode, pad.x - (pad.largeur/2), pad.y, pad.largeur, pad.hauteur)
  
  -- dessin de la balle
  love.graphics.circle(ball.drawMode, ball.x, ball.y, ball.rayon)
  
end -- fin de function draw

function love.keypressed(key)
  
  print(key)
  
end -- fin de function keypressed
