function fill_starfield(arrayName,maxStars)
  for i=1, maxStars do -- generate stars, naxStars passed as argument
    --local x = love.math.random(5, love.graphics.getWidth()-5) -- creates random number for x coordinates
    --local y = love.math.random(5, love.graphics.getHeight()-5) -- both x and y are limited to screensize, -5 px padding

    local x = love.math.random(5, 400-5) -- creates random number for x coordinates
    local y = love.math.random(5, 270-5) -- both x and y are limited to screensize, -5 px padding
    arrayName[i] = {x, y} -- put values into table
  end
end
