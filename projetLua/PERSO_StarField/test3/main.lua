--[[
*******************************************************
* STARFIELD DEMO 0.2 2016 by Chukkzy                  *
* based on the love.graphics.point example found at   *
* https://love2d.org/wiki/love.graphics.points        *
* font used: Roboto-Black by Christian Robertson      *
* https://fonts.google.com/specimen/Roboto            *
*******************************************************        ]]--

require ("update")
require ("setstars")
require ("draw")

function love.load()

  scrollerFont =love.graphics.newFont("fonts/Roboto-Black.ttf", 14)

  fullscreen_width, fullscreen_height = love.window.getDesktopDimensions()  -- detect (native) desktop resolution
  screen_width, screen_height = fullscreen_width/4,fullscreen_height/4      -- set low res screensize to the desktop dimensions divided by 4

  love.window.setMode(fullscreen_width, fullscreen_height, {fullscreen=false, vsync=true, centered=true}) -- set the windowsize to the desktop size

  canvas = love.graphics.newCanvas(screen_width,screen_height)              -- create a canvas at the 4th of the actual screensize
  canvas:setFilter("nearest","nearest")                                     -- No AA needed here!

  max_stars1 = 100 -- how many stars
  max_stars2 = 60
  max_stars3 = 40

  stars01 = {} --table that holds coordinates
  stars02 = {}
  stars03 = {}

  fill_starfield(stars01,max_stars1)  -- calls fill_starfield from setstars.lua
  fill_starfield(stars02,max_stars2)  -- and passes on arrayname and the maximum
  fill_starfield(stars03,max_stars3)  -- number of stars to generate

end



function love.update(dt)

  if love.keyboard.isDown("escape") then -- quits if user presses escape
    love.event.quit()
  end

  move_stars(stars01,40*dt) -- calls move_stars function from update.lua,
  move_stars(stars02,30*dt) -- updates stars positions
  move_stars(stars03,10*dt)

  love.graphics.setCanvas(canvas)           -- open canvas for drawing on it

  love.graphics.clear()                     -- CLS!

    renderStars(stars01,1,200,200,200,255)  -- calls renderStars from draw.lua,
    renderStars(stars02,1,100,100,100,255)  -- passes on arrayname, color in rgb
    renderStars(stars03,1,70,70,70,255)     -- and opacity value (255 = opaque)

    love.graphics.setColor(100,50,50)
    love.graphics.rectangle("fill",0,screen_height-51,screen_width,20)

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", -1, screen_height-51, screen_width+2, 20)

    love.graphics.setFont(scrollerFont)
    love.graphics.setColor(255,255,255)
    love.graphics.printf("press << ESCAPE >> to exit",0,screen_height-50,screen_width,"center",0,1,1,0,0,0,0)

  love.graphics.setCanvas()                 -- closing canvas
end



function love.draw()
  love.graphics.draw(canvas,0,0,0,4,4)      -- throw canvas on the screen
end
