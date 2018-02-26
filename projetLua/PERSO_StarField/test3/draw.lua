function renderStars(starfield,starsize,color1,color2,color3,opacity)
  love.graphics.setColor(color1,color2,color3,opacity)
  love.graphics.setPointSize(starsize)
  love.graphics.points(starfield)
end
