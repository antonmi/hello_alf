defmodule HelloAlf.Components.DoNothing do
  @moduledoc "it does nothing"

  def call(event, _), do: event
end

defmodule HelloAlf.SimplePipeline do
  @moduledoc "It's a very simple pipeline"

  use ALF.DSL

  @components [
    stage(HelloAlf.Components.DoNothing),
    stage(:add_one, count: 1),
    stage(:mult_two, count: 1)
  ]

  @doc "it adds one and sleeps a bit"
  def add_one(event, _) do
    Process.sleep(1)
    #    case rem(event, 3) do
    #      1 ->
    #        done!(event)
    #      2 ->
    #        raise "Ooops"
    #      _ ->
    #        event + 1
    #    end
    event + 1
  end

  @doc "it multiplies by two"
  def mult_two(event, _) do
    Process.sleep(2)
    event * 2
  end
end
