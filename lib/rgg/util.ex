defmodule RGG.Util do

  def distance(%RGG.Node{x: x1, y: y1, z: nil}, %RGG.Node{x: x2, y: y2, z: nil}) do
    dx = x1-x2
    dy = y1-y2
    :math.sqrt(dx*dx + dy*dy)
  end
  def distance(%RGG.Node{x: x1, y: y1, z: z1}, %RGG.Node{x: x2, y: y2, z: z2}) do
    dx = x1-x2
    dy = y1-y2
    dz = z1-x2
    :math.sqrt(dx*dx + dy*dy + dz*dz)
  end

  def degrees(adj_list) do
    Enum.map(adj_list, fn node -> length(node) end)
  end

  def average_degree(degrees) do
    n = length(degrees)
    Enum.reduce(degrees, 0,
      fn x, acc -> acc + x/n end
    )
  end

end
