# RGG-Elixir
This package generates random geometric graphs in the elixir programming language.

Hex docs at:
https://hexdocs.pm/rgg/0.1.0

Add to deps:
```elixir
 {:rgg, ">= 0.1.0"}
```

Example:

```elixir
 # Generates an adjacency list on the unit square topology with 128000 nodes, average degree of 128
 adjacency_list = RGG.unit_square(128000, 128)
 adjacency_list = RGG.unit_disc(128000, 128)
 adjacency_list = RGG.unit_sphere(128000, 128)
```
