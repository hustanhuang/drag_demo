local Draggable = require "Draggable"

function love.load(arg)
  d1 = Draggable(200, 250, 100, 100)
  d2 = Draggable(500, 250, 100, 100)
end

function love.update(dt)
  love.window.setTitle("fps = "..love.timer.getFPS())
end

function love.draw()
  d1:draw()
  d2:draw()
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    print("down")
    Draggable.emit('down', x, y)
  end
end

function love.mousemoved(x, y, dx, dy)
  if love.mouse.isDown(1) then
    print("drag")
    Draggable.emit('drag', x, y)
  end
end

function love.mousereleased(x, y, button, isTouch)
  if button == 1 then
    print("up")
    Draggable.emit('up', x, y)
  end
end
