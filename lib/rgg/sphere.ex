defmodule RGG.Sphere do

  alias RGG.Shared, as: Shared

  @doc """
  This function calculates the radius that is used to connect nodes in the sphere topology of graph.
  The parameters are n, and a.
  The returned radius will yield average degree a when connecting randomly generated points on the unit sphere.
  """
  def calculate_radius(n, a) do
    :math.sqrt(a/(n))
  end

  def random_point(id \\ nil) do
    theta = :rand.uniform()*2*:math.pi
    u = :rand.uniform()*2 - 1
    x = :math.sqrt(1 - u*u) * :math.cos(theta)
    y = :math.sqrt(1 - u*u) * :math.sin(theta)
    z = u
    %RGG.Node{
      x: (x+1)/2,
      y: (y+1)/2,
      z: (z+1)/2,
      id: id
    }
  end

  def unit_sphere(n, a) do
    r = calculate_radius(n, a)
    nodes = Enum.map(Range.new(0, n), fn id -> random_point(id) end)
    buckets = Shared.create_buckets(nodes, Shared.num_buckets(r))
    nodes |>
      Enum.map(fn node -> Shared.connect_to_neighbors(node, buckets, r) end)
  end

end
