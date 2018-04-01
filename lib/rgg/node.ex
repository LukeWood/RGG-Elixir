defmodule RGG.Node do

  defstruct [
    :x,
    :y,
    neighbors: [],
    id: nil
  ]

  def random(id \\ nil) do
    %RGG.Node{
      x: :rand.uniform(),
      y: :rand.uniform(),
      id: id
    }
  end

end
