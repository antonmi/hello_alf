defmodule HelloAlf.Worker do
  use GenServer
  alias HelloAlf.{BubbleSortPipeline, SimplePipeline}

  defstruct pid: nil

  def start_link([]) do
    GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)
  end

  @impl true
  def init(%__MODULE__{} = state) do
    ALF.Manager.start(SimplePipeline, autoscaling_enabled: true)
    #    ALF.Manager.start(SimplePipeline, autoscaling_enabled: false)
#    ALF.Manager.start(BubbleSortPipeline)

    schedule_work()
    state = %{state | pid: self()}
    {:ok, state, {:continue, :do_work}}
  end

  def handle_continue(:do_work, state) do
    send(state.pid, :work)
    {:noreply, state}
  end

  @impl true
  def handle_info(:work, state) do
    #    {:ok, pid} = Client.start(SimplePipeline)
    #    Client.call(pid, 1)

    #    (1..20) |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(10_000)

    1..5_000 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    IO.inspect("========================================================")


    Process.sleep(10_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)
    1..5 |> ALF.Manager.stream_to(HelloAlf.SimplePipeline) |> Enum.to_list()
    Process.sleep(5_000)

    #    [Enum.shuffle(1..10)]
    #    |> ALF.Manager.stream_to(BubbleSortPipeline)
    #    |> Enum.to_list()
    #    |> IO.inspect

    schedule_work()

    {:noreply, state}
  end

  def handle_info(_other, state) do
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 60_000)
  end
end
