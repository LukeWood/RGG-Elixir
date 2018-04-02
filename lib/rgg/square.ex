defmodule RGG.Square do

  alias RGG.Shared, as: Shared

  @doc """
  This function calculates the radius that is used to connect nodes in the square topology of graph.
  The parameters are n, and a.
  The returned radius will yield average degree a when connecting randomly generated points on the unit square.

  ## Examples
      iex> RGG.Square.calculate_radius_square(1000, 25)
      0.08920620580763855
  """
  def calculate_radius_square(n, a) do
    :math.sqrt(a/(n*:math.pi))
  end
  
  def random_point(id \\ nil) do
    %RGG.Node{
      x: :rand.uniform(),
      y: :rand.uniform(),
      id: id
    }
  end

  def unit_square(n, a) do
    r = calculate_radius_square(n, a)
    nodes = Enum.map(Range.new(0, n), fn id -> random_point(id) end)
    buckets = Shared.create_buckets(nodes, Shared.num_buckets(r))
    nodes |>
      Enum.map(fn node -> Shared.connect_to_neighbors(node, buckets, r) end)
  end

end
