local  Game = {}
local MAP_WIDTH = 32
local MAP_HEIGHT = 23
local TILE_WIDTH = 32 -- iso 70
local TILE_HEIGHT = 32 -- iso 70

--Atelier Tilesheet
Game.Map =  {}
Game.Map =  {
  {10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15},
  {10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 169, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 61, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15},
  {10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 61, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 169, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 58, 10, 10, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 1, 1},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37},
  {13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 55, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 55, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 169, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37},
  {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
  {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
  {19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37},
  {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37}
}

--Atelier tilemap
--Game.Map = {}
--Game.Map = {
--              {2,0,0,2,2,2,2,2,2,2},
--              {2,1,2,2,2,2,2,2,1,2},
--             {2,2,2,2,2,2,2,2,2,2},
--              {2,2,2,2,2,2,2,2,2,2},
--              {2,5,2,2,3,3,4,2,2,2},
--              {2,5,5,2,3,3,4,2,2,2},
--              {2,5,2,2,2,2,4,2,2,2},
--              {2,2,2,2,2,2,2,2,2,2},
--              {2,1,2,2,2,2,2,2,1,2},
--              {2,2,2,2,2,2,2,2,2,2}
--           }
           
Game.TileTypes = {}
Game.TileSheet = nil
Game.TileTextures = {}
function Game.Load()
  print("Chargement des textures : Start")
  --Atelier tilemap
  --Game.TileTextures[0] = nil
  --Game.TileTextures[1] = love.graphics.newImage("images/grassCenter.png")
  --Game.TileTextures[2] = love.graphics.newImage("images/liquidLava.png")
  --Game.TileTextures[3] = love.graphics.newImage("images/liquidWater.png")
  --Game.TileTextures[4] = love.graphics.newImage("images/snowCenter.png")
  --Game.TileTextures[5] = love.graphics.newImage("images/stoneCenter.png")
  
  Game.TileSheet = love.graphics.newImage("images/tilesheet.png")
  
  local nbColumns = Game.TileSheet:getWidth()/TILE_WIDTH 
  local nbLignes = Game.TileSheet:getHeight()/TILE_HEIGHT
  
  local id = 1
  Game.TileTextures[0]= nil
  for l=1,nbLignes do
    for c=1,nbColumns do
      
      Game.TileTextures[id] = love.graphics.newQuad((c-1)*TILE_WIDTH,(l-1)*TILE_HEIGHT,TILE_WIDTH,TILE_HEIGHT, Game.TileSheet:getWidth(), Game.TileSheet:getHeight())
      
      id = id+1
    end
  end

  Game.TileTypes[10] = "Grass"
  Game.TileTypes[11] = "Grass"
  Game.TileTypes[13] = "Sand"
  Game.TileTypes[14] = "Sand"
  Game.TileTypes[15] = "Sand"
  Game.TileTypes[19] = "Water"
  Game.TileTypes[20] = "Water"
  Game.TileTypes[21] = "Water"
  Game.TileTypes[37] = "Lava"
  Game.TileTypes[55] = "Tree"
  Game.TileTypes[58] = "Tree"
  Game.TileTypes[61] = "Tree"
  Game.TileTypes[68] = "Tree"
  Game.TileTypes[169] = "Rock"
  Game.TileTypes[129] = "Rock"
  
  
  print("Chargement des textures : End")
end

function Game.Draw()
  for l=1,MAP_HEIGHT do
    for c=1,MAP_WIDTH do
      local id = Game.Map[l][c]
      local texQuad = Game.TileTextures[id]
      if texQuad ~= nil then
        love.graphics.draw(Game.TileSheet, texQuad, (c-1)*TILE_WIDTH, (l-1)*TILE_HEIGHT)
      end
    end
  end
  
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  local colonne = math.floor(x/TILE_WIDTH)+1
  local ligne = math.floor(y/TILE_HEIGHT)+1
  if colonne>0 and colonne<=MAP_WIDTH and ligne>0 and ligne<=MAP_HEIGHT then
    local idCase = Game.Map[ligne][colonne]
    love.graphics.print("ID: "..tostring(idCase),10,740)
  else
    love.graphics.print("Hors de la fenetre",10,740)
  end
end

return Game