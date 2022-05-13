defmodule HelloAlf.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_alf,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {HelloAlf.Application, []}
    ]
  end

  defp deps do
    [
      #       {:alf, github: "antonmi/ALF", branch: "main"}
      {:alf, path: "/Users/anton.mishchukkloeckner.com/elixir/ALF"}
    ]
  end
end
