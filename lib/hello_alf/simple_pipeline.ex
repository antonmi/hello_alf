defmodule HelloAlf.SimplePipeline do
  use ALF.DSL

  @components [
    stage(:do_nothing),
    stage(:add_one, count: 5),
    stage(:mult_two, count: 10)
  ]

  def do_nothing(event, _), do: event

  def add_one(event, _) do
    Process.sleep(1)
    event + 1
  end

  def mult_two(event, _) do
    Process.sleep(2)
    event * 2
  end
end
