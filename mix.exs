defmodule RGG.MixProject do
  use Mix.Project

  def project do
    [
      app: :rgg,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package()
    ]
  end

  defp description do
    "This package generates random geometric graphs"
  end

  defp package do
    [
      name: "rgg",
      deps: deps(),
      licenses: ["MIT"],
      maintainers: ["Luke Wood"],
      links: %{"GitHub" => "https://github.com/LukeWood/RGG-Elixir"},
      source_url: "https://github.com/LukeWood/RGG-Elixir"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
