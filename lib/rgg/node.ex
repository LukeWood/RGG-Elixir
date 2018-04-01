defmodule RGG.Node do

  @moduledoc """
    This module defines the node struct used in RGG generation.
  """

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
