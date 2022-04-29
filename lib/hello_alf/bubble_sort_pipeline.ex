defmodule HelloAlf.BubbleSortPipeline do
  use ALF.DSL

  defstruct [:list, :new_list, :max, :ready]

  @components [
    stage(:build_struct),
    goto_point(:goto_point),
    stage(:find_max),
    stage(:update_new_list, count: 3),
    stage(:rebuild_list, count: 4),
    clone(:logging, to: [stage(:report_step), dead_end(:after_report)]),
    goto(:goto_if, to: :goto_point),
    stage(:format_output)
  ]

  def build_struct(list, _) do
    %__MODULE__{list: list, new_list: [], max: 0, ready: false}
  end

  def find_max(struct, _) do
    %{struct | max: Enum.max(struct.list)}
  end

  def update_new_list(struct, _) do
    %{struct | new_list: [struct.max | struct.new_list]}
  end

  def rebuild_list(struct, _) do
    %{struct | list: struct.list -- [struct.max]}
  end

  def goto_if(struct, _) do
    !Enum.empty?(struct.list)
  end

  def report_step(struct, _) do
    #    IO.inspect("Step: #{inspect struct}", charlists: :as_lists)
    struct
  end

  def format_output(struct, _) do
    struct.new_list
  end
end
