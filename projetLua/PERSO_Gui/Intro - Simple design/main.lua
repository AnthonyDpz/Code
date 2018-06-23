-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local GUI = require("GUI")

local buttonTest1
local groupTest

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  buttonTest1 = newButton(10,10,200,150,"Hello")
  buttonTest2 = newButton(10,200,200,150,"Hello 2")
  
  buttonTest1:setVisible(true)
  buttonTest2:setVisible(true)
  
  groupTest = GUI.newGroup()
  groupTest:addElement(buttonTest1)
  groupTest:addElement(buttonTest2)
  
end

function love.update(dt)

end

function love.draw()
  
  groupTest:draw()
    
end

function love.keypressed(key)
  
  print(key)
  
end
  