defmodule RGG.Shared do
  @doc """
  This function calculates the maximum number of buckets we can use when connecting nodes to achieve linear runtime when connecting the nodes..
  The only parameter is r as we need to make sure we place nodes within radius r of each other within 1 bucket of each other.
  ## Examples
      iex>RGG.Square.calculate_radius_square(1000, 25) |> RGG.Shared.num_buckets()
      10
  """
  def num_buckets(r) do
    round(max(:math.floor(1/r) - 1, 1))
  end

  @doc """
  This function selects the proper bucket numbers for a node based on it's x location, y location, and the number of buckets
      iex>RGG.Shared.get_bucket_from_node(%RGG.Node{x: 0, y: 0}, 10)
      {0, 0}
      iex>RGG.Shared.get_bucket_from_node(%RGG.Node{x: 1, y: 0.5}, 10)
      {10, 5}
  """
  def get_bucket_from_node(%RGG.Node{x: x, y: y}, number_buckets) do
    {round(x * number_buckets), round(y * number_buckets)}
  end

  @doc """
  This function returns the nodes that must be tested in order to connect a node in the graph.
  """
  def get_adjacent_nodes_for_bucket(node, buckets) do
    offsets = [
      {-1, -1}, {-1, 0}, {-1, 1},
      {0,  -1}, {0,  0}, {0,  1},
      {1,  -1}, {1,  0}, {1,  1},
    ]
    {x, y} = get_bucket_from_node(node, map_size(buckets))
    Enum.map(offsets,
      fn {dx, dy} ->
        Map.get(buckets, x+dx, %{}) |>
          Map.get(y+dy, [])
      end) |>
      List.flatten
  end

  @doc """
  This function maps nodes into their appropriate buckets before connection.
  """
  def create_buckets(nodes, number_of_buckets) do
    Enum.reduce(nodes, %{}, curry_put_node_in_bucket(number_of_buckets))
  end

  def curry_put_node_in_bucket(n) do
    fn node, buckets ->
      {x, y} = get_bucket_from_node(node, n)
      inner_map = Map.get(buckets, x, %{})
      bucket = [node | Map.get(inner_map, y, [])]
      Map.put(buckets, x, Map.put(inner_map, y, bucket))
    end
  end


  @doc """
  This function connects nodes to their appropriate neighbors
  """
  def connect_to_neighbors(node = %RGG.Node{id: id}, buckets, r) do
    get_adjacent_nodes_for_bucket(node, buckets) |>
      Enum.reject(
        fn
          %RGG.Node{id: ^id} -> true
          node2 -> RGG.Util.distance(node, node2) > r
      end) |>
      Enum.map(fn %RGG.Node{id: id} -> id end)
  end

end
