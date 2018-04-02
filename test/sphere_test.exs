defmodule RGG.SphereTest do
  use ExUnit.Case
  doctest RGG.Sphere

  describe "RGG Sphere" do
    test "n=10000, a=25" do
      n=10000
      a=25
      adj_list = RGG.unit_sphere(n, a)
      degrees = RGG.Util.degrees(adj_list)
      average_degree = RGG.Util.average_degree(degrees)
      err = abs((a - average_degree)/a)
      message = "Expected an average degree of #{a}, ended up with #{average_degree}"
      assert(abs(err) < 0.2, message)
    end
  end

end
