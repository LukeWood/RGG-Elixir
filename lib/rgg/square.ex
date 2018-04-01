defmodule RGG.Square do

  defmodule StaticCalculations do

    @doc """
    This function calculates the radius that is used to connect nodes in the square topology of graph.
    The parameters are n, and a.
    The returned radius will yield average degree a when connecting randomly generated points on the unit square.

    ## Examples
        iex> RGG.Square.StaticCalculations.calculate_radius_square(1000, 25)
        0.08920620580763855
    """
    def calculate_radius_square(n, a) do
      :math.sqrt(a/(n*:math.pi))
    end

    @doc """
    This function calculates the maximum number of buckets we can use when connecting nodes to achieve linear runtime when connecting the nodes..
    The only parameter is r as we need to make sure we place nodes within radius r of each other within 1 bucket of each other.
    ## Examples
        iex>RGG.Square.StaticCalculations.calculate_radius_square(1000, 25) |> RGG.Square.StaticCalculations.num_buckets()
        10
    """
    def num_buckets(r) do
      round(max(:math.floor(1/r) - 1, 1))
    end
  end

  defmodule Bucketization do

    def get_bucket_from_node(%RGG.Node{x: x, y: y}, n) do
      {round(x * n), round(y * n)}
    end

    def curry_put_node_in_bucket(n) do
      fn node, buckets ->
        {x, y} = get_bucket_from_node(node, n)
        inner_map = Map.get(buckets, x, %{})
        bucket = [node | Map.get(inner_map, y, [])]
        Map.put(buckets, x, Map.put(inner_map, y, bucket))
      end
    end

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

    def find_buckets(nodes, number_of_buckets) do
      Enum.reduce(nodes, %{}, curry_put_node_in_bucket(number_of_buckets))
    end
  end

  def connect_to_neighbors(node, buckets, r) do
    Bucketization.get_adjacent_nodes_for_bucket(node, buckets) |>
      Enum.reject(fn node2 ->
        RGG.Util.distance2d(node, node2) < r
      end) |>
      Enum.map(fn %RGG.Node{id: id} -> id end)
  end

  def unit_square(n, a) do
    r = StaticCalculations.calculate_radius_square(n, a)
    nodes = Enum.map(Range.new(0, n), fn id -> RGG.Node.random(id) end)
    buckets = Bucketization.find_buckets(nodes, StaticCalculations.num_buckets(r))
    nodes |>
      Enum.map(fn node -> connect_to_neighbors(node, buckets, r) end)
  end

end
