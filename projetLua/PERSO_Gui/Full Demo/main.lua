-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local myGUI = require("GCGUI")
local mainFont = love.graphics.newFont("kenvector_future_thin.ttf", 15)
love.graphics.setFont(mainFont)

local groupTest

function onPanelHover(pState)
  print("Panel is hover:"..pState)
end

function onCheckboxSwitch(pState)
  print("Switch is:"..pState)
end

function love.load()
  
  love.window.setTitle("Gamecodeur GUI Demo")
  
  love.graphics.setBackgroundColor(63, 124, 182)
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  buttonYes = myGUI.newButton(10, 20, 100, 43,"Yes", mainFont, {151, 220, 250})
  buttonYes:setImages(
    love.graphics.newImage("button_default.png"),
    love.graphics.newImage("button_hover.png"),
    love.graphics.newImage("button_pressed.png")
    )
  buttonNo = myGUI.newButton(115, 20, 100, 43,"No", mainFont, {151, 220, 250})
  buttonNo:setImages(
    love.graphics.newImage("button_default.png"),
    love.graphics.newImage("button_hover.png"),
    love.graphics.newImage("button_pressed.png")
    )
  
  buttonTest3 = myGUI.newButton(55, 100, 120, 80,"No images", mainFont, {250, 250, 250})
  
  panelTest1 = myGUI.newPanel(10, 220, 300, 200)
  panelTest1:setImage(love.graphics.newImage("panel1.png"))
  panelTest1:setEvent("hover", onPanelHover)

  panelTest2 = myGUI.newPanel(350, 250)
  panelTest2:setImage(love.graphics.newImage("panel2.png"))

  textTest = myGUI.newText(panelTest1.X+10, panelTest1.Y,
                           300, 28, "HULL STATUS", mainFont, "", "center", {151, 220, 250})
  
  checkBoxTest1 = myGUI.newCheckbox(250, 30, 24, 24)
  checkBoxTest1:setImages(
    love.graphics.newImage("dotRed.png"),
    love.graphics.newImage("dotGreen.png")
  )
  checkBoxTest1:setEvent("pressed", onCheckboxSwitch)
  
  title1 = myGUI.newText(panelTest1.X + 35, panelTest1.Y + 45, 0, 0,
                           "Shield Generator", mainFont, "", "", {157, 164, 174})
  
  progressTest1 = myGUI.newProgressBar(panelTest1.X + 35, panelTest1.Y + 68, 220, 26, 100,
                                      {50,50,50}, {250, 129, 50})
                                    
  progressTest1:setImages(love.graphics.newImage("progress_grey.png"),
                         love.graphics.newImage("progress_orange.png"))

  
  title2 = myGUI.newText(panelTest1.X + 35, panelTest1.Y + 45 + 70, 0, 0,
                           "Generator Shield", mainFont, "", "", {157, 164, 174})
  
  progressTest2 = myGUI.newProgressBar(panelTest1.X + 35, panelTest1.Y + 68 + 70, 220, 26, 100,
                                      {50,50,50}, {250, 129, 50})
                                    
  progressTest2:setImages(love.graphics.newImage("progress_grey.png"),
                         love.graphics.newImage("progress_green.png"))
                       
  progressTest2:setValue(0)

  groupTest = myGUI.newGroup()
  groupTest:addElement(buttonYes)
  groupTest:addElement(buttonNo)
  groupTest:addElement(buttonTest3)
  groupTest:addElement(panelTest1)
  groupTest:addElement(panelTest2)
  groupTest:addElement(checkBoxTest1)
  groupTest:addElement(textTest)
  groupTest:addElement(title1)
  groupTest:addElement(progressTest1)
  groupTest:addElement(title2)
  groupTest:addElement(progressTest2)
  
end

function love.update(dt)

  groupTest:update(dt)
  
  if progressTest1.Value > 0.01 then
    progressTest1:setValue(progressTest1.Value - 0.01)
  end
  if progressTest2.Value < 100 then
    progressTest2:setValue(progressTest2.Value + 0.01)
  end

end

function love.draw()
  
  groupTest:draw()
    
end

function love.keypressed(key)
  
  print(key)
  
end
  