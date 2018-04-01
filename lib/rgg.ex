defmodule RGG do

  @moduledoc """
    The RGG module exposes an api to generate random geometric graphs on various topologies.
    The parameters for all of the generation functions are n for number of nodes and a for the average desired degree.
  """

  @doc """
    Generates a random geometric graph on the topology of a unit square.
    Requires the parameters n for the number of nodes and a for the average degree of the nodes
    Returns an Adjacency List
  """
  defdelegate unit_square(n, a), to: RGG.Square
  defdelegate unit_disc(n, a),   to: RGG.Disc
  defdelegate unit_sphere(n, a), to: RGG.Sphere

end
