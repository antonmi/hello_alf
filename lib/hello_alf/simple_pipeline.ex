defmodule HelloAlf.SimplePipeline do
  @moduledoc "It's a very simple pipeline"

  use ALF.DSL

  @components [
    stage(:do_nothing),
    stage(:add_one, count: 5),
    stage(:mult_two, count: 10)
  ]

  @doc "it does nothing"
  def do_nothing(event, _), do: event

  @doc "it adds one and sleeps a bit"
  def add_one(event, _) do
    Process.sleep(1)
    event + 1
  end

  @doc "it multiplies by two"
  def mult_two(event, _) do
    Process.sleep(2)
    event * 2
  end
end
