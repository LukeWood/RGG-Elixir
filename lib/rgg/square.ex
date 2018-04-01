defmodule RGG.Square do

  def calculate_radius_square(n, a) do
    :math.sqrt(a/(n*:math.pi))
  end

  def num_buckets(r) do
    round(max(:math.floor(1/r) - 1, 1))
  end

  def get_bucket_from_node(%RGG.Node{x: x, y: y}, n) do
    {round(x * n), round(y * n)}
  end

  def curry_put_node_in_bucket(n) do
    fn node, buckets ->
      {x, y} = get_bucket_from_node(node, n)
      inner_map = Map.get(buckets, x, %{})
      bucket = Map.get(inner_map, y, [])
      bucket = [node | bucket]
      Map.put(buckets, x, Map.put(inner_map, y, bucket))
    end
  end

  def not_nil(nil), do: false
  def not_nil(_),   do: true

  def get_adjacent_nodes_for_bucket(node, buckets) do
  	offsets = [{1, -1}, {1, 0}, {1, 1}, {0,1}]
    {x, y} = get_bucket_from_node(node, map_size(buckets))
    Enum.map(offsets,
      fn {dx, dy} ->
        Map.get(buckets, x+dx, %{}) |>
          Map.get(y+dy, [])
      end) |>
      List.flatten
  end

  def find_buckets(nodes, r) do
    n = num_buckets(r)
    Enum.reduce(nodes, %{}, curry_put_node_in_bucket(n))
  end

  def connect_to_neighbors(node, buckets, r) do
    get_adjacent_nodes_for_bucket(node, buckets) |>
      Enum.filter(fn node2 ->
        RGG.Util.distance2d(node, node2) < r
      end) |>
      Enum.map(fn %RGG.Node{id: id} -> id end)
  end

  def unit_square(n, a) do
    r = calculate_radius_square(n, a)
    nodes = Enum.map(Range.new(0, n), fn id -> RGG.Node.random(id) end)
    buckets = find_buckets(nodes, r)
    nodes |>
      Enum.map(fn node -> connect_to_neighbors(node, buckets, r) end)
  end

end
