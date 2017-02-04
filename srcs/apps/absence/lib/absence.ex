defmodule Absence do
  alias Db.Providers.AbsenceProvider

  def start(type, args) do
    Absence.Application.start(type, args)
  end

  def get_message() do
    msg = AbsenceProvider.get_message(:absence_provider)
    IO.puts msg
    msg
  end

  #TODO remove this function
  def urls({ action, id }) do
    case action do
      :absences ->
        "http://localhost:4000/api/absences"
      :absence ->
        "http://localhost:4000/api/absences/#{id}"
      _ ->
        ""
    end

  end

  def data_from(url) do
    response =
      Tesla.get(url).body
      |> Poison.Parser.parse!
    response["data"]
  end
end
