local Class = require "class"
local Draggable = Class{}

-- fake inheritance of some methods of Signal
Draggable.Signal = require "signal"
Draggable.register = Draggable.Signal.register
Draggable.emit = Draggable.Signal.emit
Draggable.remove = Draggable.Signal.remove

function Draggable:init(x, y, w, h)
  self.x, self.y = x, y
  self.w, self.h = w, h

  self.isDragged = false
  self.dx, self.dy = 0, 0

  -- closures (maybe it can be improved)
  self.handles = {
    down = function(x, y)
      if self.x < x and x < self.x+self.w and
         self.y < y and y < self.y+self.h then
        self.isDragged = true
        self.dx, self.dy = x-self.x, y-self.y
      end
    end,
    drag = function(x, y)
      if self.isDragged then
        self.x, self.y = x-self.dx, y-self.dy
      end
    end,
    up = function(x, y)
      self.isDragged = false
      self.dx, self.dy = 0, 0
    end}
  for k, v in pairs(self.handles) do
    Draggable.register(k, v)
  end
end

function Draggable:draw()
  love.graphics.rectangle("fill",
    self.x, self.y, self.w, self.h)

  love.graphics.setColor(102, 204, 255)
  love.graphics.print(string.format(
    "x, y = %d, %d\ndx, dy = %d, %d\ndragged = %s",
    self.x, self.y, self.dx, self.dy, self.isDragged),
    self.x, self.y)
  love.graphics.setColor(255, 255, 255)
end

-- this should be called when the draggable object is no longer needed
function Draggable:unregister()
  for k, v in pairs(self.handles) do
    Draggable.remove(k, v)
  end
end

return Draggable
