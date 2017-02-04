defmodule Db.Providers.AbsenceProvider do
  use GenServer

  @messages ["test", "test1", "test2"]

  def start_link(name) do
    { :ok, pid } = GenServer.start_link(__MODULE__, :ok, [])
    Process.register(pid, name)
    { :ok, pid }
  end

  def init(:ok), do: { :ok, @messages }

  def handle_call(:next_message, _from, [h | t]), do: {:reply, h, t ++ [h]}

  ## public API

  def get_message(server), do: GenServer.call(server, :next_message)
end
