local  donjon = {}
donjon.nombreColomne = 9
donjon.nombreLigne = 6
donjon.map = {}

function GenereDonjon()
  print("GenereDonjon")
  
  --reset le donjon
  donjon.map = {}
  for nLigne=1,donjon.nombreLigne do
    donjon.map[nLigne] = {}
    for nColomne=1,donjon.nombreColomne do
      donjon.map[nLigne][nColomne] = "empty"
    end
  end
  
end

function testDonjon()
  donjon.map[1][5] = "unvisited"
  donjon.map[2][5] = "unvisited"
  donjon.map[3][5] = "unvisited"
  donjon.map[4][5] = "unvisited"
  donjon.map[5][5] = "unvisited"
  donjon.map[6][5] = "unvisited"
  donjon.map[3][4] = "unvisited"
  donjon.map[3][3] = "unvisited"
  donjon.map[3][6] = "unvisited"
  donjon.map[3][7] = "unvisited"
end

function love.load()
  GenereDonjon()
  testDonjon()
end

function love.update(dt)
  
end

function love.draw()
  
  local x = 5
  local y = 5
  local largeurCase = 34
  local hauteurCase = 13
  local espaceCase = 5
  
   for nLigne=1,donjon.nombreLigne do
     
     x = 5
    
    for nColomne=1,donjon.nombreColomne do
      
      --dessine la cellule
      if donjon.map[nLigne][nColomne] == "empty" then
        love.graphics.setColor(60, 60, 60)
      else
        love.graphics.setColor(255, 255, 255)
      end
      
      love.graphics.rectangle("fill", x, y, largeurCase, hauteurCase)
      
      x = x + largeurCase + espaceCase
      
    end
    
    y = y + hauteurCase + espaceCase
    
  end
  
  love.graphics.setColor(255, 255, 255)
  
end

function love.keypressed(key)
  print(key)
  if key == "escape" then
    love.event.quit(0)
  end
end