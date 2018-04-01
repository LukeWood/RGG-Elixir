defmodule RGG.Util do
  def distance2d(%RGG.Node{x: x1, y: y1}, %RGG.Node{x: x2, y: y2}) do
    dx = x1-x2
    dy = y1-y2
    :math.sqrt(dx*dx + dy*dy)
  end
end
