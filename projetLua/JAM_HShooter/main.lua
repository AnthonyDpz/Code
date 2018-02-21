-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

math.randomseed(love.timer.getTime())

player={}

-- Listes d'elements
liste_Sprites = {}
liste_Tirs = {}
liste_Aliens = {}

sonShoot = love.audio.newSource("sons/shoot.wav", "static")

-- niveau 16x12
niveau1 = {}
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,0,1,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {0,0,0,0,0,0,1,1,1,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
table.insert(niveau1, {1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,3,3,3,3,2,2,2,2,1,1,1,1,1,3,3})

-- Images des tuiles
imgTuiles = {}
local n
for n=1,3 do
  imgTuiles[n] = love.graphics.newImage("images/tuile_"..n..".png")
end

--Camera
camera = {}
camera.x = 0

function CreeAlien(pType, pX, pY)
  
  local nomImage=""
  if pType == 1 then
    nomImage = "enemy1"
  elseif pType == 2 then
    nomImage = "enemy2"
  elseif pType == 3 then
    nomImage = "enemy3"
  end
  
  local alien = CreeSprite(nomImage,pX,pY)
  
  local directionAleatoire = math.random(-1,1)
  
  
  if pType == 1 then
    alien.vX = -2
    alien.vY = 0
  elseif pType == 2 then
    alien.vX = -2
    alien.vY = directionAleatoire
  elseif pType == 3 then
    alien.vX = -3
    alien.vY = -3*directionAleatoire
  end
  
  table.insert(liste_Aliens, alien)
  
end

function CreeSprite(pNomImage, pX, pY)

  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.toDelete = false
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.l = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()
  
  table.insert(liste_Sprites, sprite)

  return sprite

end

function love.load()
  
  love.window.setMode(1024, 768)
  love.window.setTitle("defoncator")
  -- charge les dimensions de la fenetre
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  DemarreJeu()
  
end

function DemarreJeu()
  --raz player
  player = CreeSprite("heros", 40, hauteur/2)
  --raz alien
  CreeAlien(1,largeur-50,100)
  CreeAlien(2,largeur-50,300)
  CreeAlien(3,largeur-50,500)
  --raz camera
  camera.x = 0
end

function love.update(dt)
  
  --avance camera
  camera.x = camera.x - 1

  
  local n
  
  -- traitement des tirs
  for n=#liste_Tirs,1,-1 do
    local tir = liste_Tirs[n]
    tir.x = tir.x + tir.v
    
    --verifier si tir sorti de l'ecran
    if tir.y < 0 or tir.y > hauteur then
      table.remove(liste_Tirs, n)
      tir.toDelete = true
    end
    if tir.x < 0 or tir.x > largeur then
      table.remove(liste_Tirs, n)
      tir.toDelete = true
    end
  end
  
  -- traitement des aliens
  for n=#liste_Aliens,1,-1 do
    local alien = liste_Aliens[n]
    alien.x = alien.x + alien.vX
    alien.y = alien.y + alien.vY
    
    --verifier si alien sorti de l'ecran
    if alien.y < 0 or alien.y > hauteur then
      table.remove(liste_Aliens, n)
      alien.toDelete = true
    end
    if alien.x < 0 or alien.x > largeur then
      table.remove(liste_Aliens, n)
      alien.toDelete = true
    end
    
  end
  
  -- verifier si sprite a detruire
  for n=#liste_Sprites,1,-1 do
    local sprite = liste_Sprites[n]
    if sprite.toDelete == true then
      table.remove(liste_Sprites, n)
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

  -- dessin du niveau
  local nbLignes = #niveau1
  local ligne,colonne
  local x = 0 + camera.x
  local y = 0 
  
  for ligne=1, nbLignes do
    for colonne=1, 32 do
      local tuile = niveau1[ligne][colonne]
      if tuile > 0 then
        love.graphics.draw(imgTuiles[tuile],x,y,0,2,2)
      end
      x = x + 64
    end
    x= camera.x
    y = y + 64
  end
    
  local n
  
  for n=1, #liste_Sprites do
    local s = liste_Sprites[n]
    love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.l/2, s.h/2)
  end
  
  love.graphics.print("nombre de tirs : "..#liste_Tirs,0 ,0)
  love.graphics.print("nombre de sprites : "..#liste_Sprites,0 ,13)
  
end

function love.keypressed(key)
  
  print(key)
  
  if key == "space" then
    local tir = CreeSprite("laser1", player.x + player.l, player.y)
    tir.v = 10
    table.insert(liste_Tirs, tir)
    sonShoot:play()
  end
  
  if key == "escape" then
    liste_Sprites = {}
    liste_Tirs = {}
    liste_Aliens = {}
    DemarreJeu()
  end
  
end