local hero = {}

hero.images = {}
hero.images[1] = love.graphics.newImage("images/player_1.png")
hero.images[2] = love.graphics.newImage("images/player_2.png")
hero.images[3] = love.graphics.newImage("images/player_3.png")
hero.images[4] = love.graphics.newImage("images/player_4.png")
hero.imgCurrent = 1
hero.line = 1
hero.column = 1
hero.keyPressed = false

function hero.Update(pMap, dt)
  hero.imgCurrent = hero.imgCurrent + (5*dt)
  if math.floor(hero.imgCurrent) > #hero.images then
    hero.imgCurrent = 1
  end
  if love.keyboard.isDown("up", "right", "down","left") then
    
    if hero.keyPressed == false then
      
      if love.keyboard.isDown("up") and hero.line > 1  then
        hero.line = hero.line -1
      end
      if love.keyboard.isDown("right") and hero.column < pMap.MAP_WIDTH then
        hero.column = hero.column +1
      end
      if love.keyboard.isDown("down") and hero.line < pMap.MAP_HEIGHT  then
        hero.line = hero.line +1
      end
      if love.keyboard.isDown("left") and hero.column > 1  then
        hero.column = hero.column -1
      end
      
      hero.keyPressed = true
      
    end
  else 
    hero.keyPressed = false 
  end
  
end

function hero.Draw(pMap)
  local x = (hero.column-1)*pMap.TILE_WIDTH
  local y = (hero.line-1)*pMap.TILE_HEIGHT
  love.graphics.draw(hero.images[math.floor(hero.imgCurrent)], x, y, 0, 2, 2)
end

return hero