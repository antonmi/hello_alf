defmodule HelloAlf.SimplePipeline do
  use ALF.DSL

  @components [
    stage(:add_one, count: 2),
    stage(:mult_two)
  ]

  def add_one(event, _) do
    Process.sleep(300)
    event + 1
  end

  def mult_two(event, _) do
    Process.sleep(300)
    event * 2
  end
end
