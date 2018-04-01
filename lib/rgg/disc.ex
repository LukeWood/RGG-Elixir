defmodule RGG.Disc do

  alias RGG.Shared, as: Shared

  @doc """
  This function calculates the radius that is used to connect nodes in the disc topology of graph.
  The parameters are n, and a.
  The returned radius will yield average degree a when connecting randomly generated points on the unit disc.
  """

  def calculate_radius(n, a) do
    :math.sqrt(a/n)/2
  end

  @center_node %RGG.Node{x: 0.5, y: 0.5}

  def validate(node = %RGG.Node{id: id}) do
    if RGG.Util.distance(node, @center_node) < 0.5 do
      node
    else
      random_point(id)
    end
  end

  def random_point(id) do
    %RGG.Node{
      x: :rand.uniform(),
      y: :rand.uniform(),
      id: id
    } |> validate()
  end

  def unit_disc(n, a) do
    r = calculate_radius(n, a)
    nodes = Enum.map(Range.new(0, n), fn id -> random_point(id) end)
    buckets = Shared.create_buckets(nodes, Shared.num_buckets(r))
    nodes |>
      Enum.map(fn node -> Shared.connect_to_neighbors(node, buckets, r) end)
  end

end
