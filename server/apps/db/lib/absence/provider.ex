defmodule Db.Absence.Provider do
  use GenServer
  use Absinthe.Schema

  def start_link(name) do
    { :ok, pid } = GenServer.start_link(__MODULE__, :ok, [])
    Process.register(pid, name)
    { :ok, pid }
  end

  def init(:ok), do: { :ok, :running }

  def handle_call({:absences, request}, _from, state) do
    result = (request |> Absinthe.run(Db.Schema))

    {
      :reply,
      result,
      state
    }
  end

  ## public API

  def reply(server, request) do
    GenServer.call(server, {:absences, request})
  end
end
