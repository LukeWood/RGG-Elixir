defmodule RGG.Square do

  def calculate_radius_square(n, a) do
    :math.sqrt(a/(n*:math.pi))
  end

  def num_buckets(r) do
    round(max(:math.floor(1/r) - 1, 1))
  end

  def generate_buckets(num_buckets) do
    Enum.map(Range.new(0, num_buckets+1), fn n -> {n, %{}} end) |>
      Enum.into(%{})
  end

  def create_buckets(r) do
    num_buckets(r) |>
      generate_buckets
  end

  def curry_put_node_in_bucket(n) do
    fn node, buckets ->
      x = round(Map.get(node, :x) * n)
      y = round(Map.get(node, :y) * n)

      bucket=  Map.get(buckets, x) |> Map.get(y, [])
      bucket =[node | bucket]
      inner_map = Map.get(buckets, x)
      inner_map = Map.put(inner_map, y, bucket)
      buckets |>
        Map.put(x, inner_map)
    end
  end

  def find_buckets(nodes, r) do
    n = num_buckets(r)
    buckets = create_buckets(r)
    Enum.reduce(nodes, buckets, curry_put_node_in_bucket(n))
  end

  def connect_to_neighbors(node, buckets, r) do

  end

  def unit_square(n, a) do
    r = calculate_radius_square(n, a)
    nodes = Enum.map(Range.new(0, n), fn _ -> RGG.Node.random end)
    buckets = find_buckets(nodes, r)

    #nodes |>
    #  Enum.map(fn node -> connect_to_neighbors(node, buckets, r) end)
  end

end
