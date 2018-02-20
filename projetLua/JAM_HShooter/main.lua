-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

testFPS=0

player={}
sprites = {}
tirs = {}

sonShoot = love.audio.newSource("sons/shoot.wav", "static")

function CreeSprite(pNomImage, pX, pY)

  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.toDelete = false
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.l = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()
  
  table.insert(sprites, sprite)

  return sprite

end

function love.load()
  
  love.window.setMode(1024, 768)
  love.window.setTitle("defoncator")
  -- charge les dimensions de la fenetre
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  player = CreeSprite("heros", 40, hauteur/2)
  
  
  
end

function love.update(dt)
  testFPS=dt
  local n
  for n=#tirs,1,-1 do
    local tir = tirs[n]
    tir.x = tir.x + tir.v
    
    --verifier si tir sorti de l'ecran
    if tir.y < 0 or tir.y > hauteur then
      table.remove(tirs, n)
      tir.toDelete = true
    end
    if tir.x < 0 or tir.x > largeur then
      table.remove(tirs, n)
      tir.toDelete = true
    end
  end
  -- verifier si sprite a detruire
  for n=#sprites,1,-1 do
    local sprite = sprites[n]
    if sprite.toDelete == true then
      table.remove(sprites, n)
    end
  end
  
  if love.keyboard.isDown("right") and player.x < largeur then
    player.x = player.x + 2
  end
  if love.keyboard.isDown("left") and player.x > 0 then
    player.x = player.x - 2
  end
  if love.keyboard.isDown("up") and player.y > 0 then
    player.y = player.y - 2
  end
  if love.keyboard.isDown("down") and player.y < hauteur then
    player.y = player.y + 2
  end
end

function love.draw()
  
  local n
  for n=1, #sprites do
    local s = sprites[n]
    love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
  end
  
  love.graphics.print("nombre de tirs : "..#tirs,0 ,0)
  love.graphics.print("nombre de sprites : "..#sprites,0 ,13)
  love.graphics.print("nombre de fps : "..math.floor(60/testFPS),0 ,26)
  
end

function love.keypressed(key)
  
  print(key)
  
  if key == "space" then
    local tir = CreeSprite("laser1", player.x + player.l, player.y)
    tir.v = 10
    table.insert(tirs, tir)
    sonShoot:play()
  end
  
end