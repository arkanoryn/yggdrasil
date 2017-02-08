defmodule Absence.Public.Actions do
  # TODO
  @moduledoc """
  """

  alias Db.Absence.Provider
  alias Absence.Public.Requests

  def all() do
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    Provider.reply(:absence_provider, Requests.all(wished_fields))
  end

  def find(id) do
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    Provider.reply(:absence_provider, Requests.get(id, wished_fields))
  end

  def create(absence_params) do
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    # TODO use guard instead of case
    case Absence.Public.Validators.valid_absences?(absence_params) do
      true ->
        Provider.reply(:absence_provider, Requests.create(absence_params, wished_fields))
      false ->
        {:ok, %{error: "invalid absence params"} }
    end
  end

  def update(id, absence_params) do
    id = String.to_integer(id)
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    # TODO use guard instead of case
    case Absence.Public.Validators.valid_absences?(absence_params) do
      true ->
        Provider.reply(:absence_provider, Requests.update(id, absence_params, wished_fields))
      false ->
        {:ok, %{error: "invalid absence params"} }
    end
  end

  def delete(id) do
    Provider.reply(:absence_provider, Requests.delete(id))
  end
end
