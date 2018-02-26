function move_stars(starfield, speed)
  for i, star in ipairs(starfield) do
    x = star[1]
    y = star[2]
    if x > 480 then
      x = 1
    end
    starfield[i] = {x+speed, y}
  end
end
