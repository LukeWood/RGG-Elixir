defmodule RGG.Node do

  @moduledoc """
    This module defines the node struct used in RGG generation.
  """

  defstruct [
    :x,
    :y,
    z: nil,
    neighbors: [],
    id: nil
  ]

end
