defmodule RGGTest do
  use ExUnit.Case

  test "RGG Square" do
    n=1000
    a=25
    adj_list = RGG.unit_square(n, a)
    degrees = Enum.map(adj_list, fn node -> length(node) end)
    average_degree = Enum.reduce(degrees, 0,
      fn x, acc -> acc + x/n end
    )
    err = (a - average_degree)/a
    assert(err < 0.2, "Error on average degree of #{err}, expected < 0.2")

  end

end
