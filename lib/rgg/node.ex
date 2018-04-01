defmodule RGG.Node do

  defstruct [
    :x,
    :y,
    neighbors: []
  ]

  def random do
    %RGG.Node{
      x: :rand.uniform(),
      y: :rand.uniform()
    }
  end

end
