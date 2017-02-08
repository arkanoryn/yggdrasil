defmodule Absence.Public.Actions do
  @moduledoc ~S"""
  Defines Public Business Logic of Absence.

  # Public: definition
  By Public, we mean that the response must be define in a way where datas
  can be returned to an end-user as is, without further operations.
  Datas must therefore be cleaned and define as a string.

  # Return value
  Functions should always return a tuple as follow:
  ```
  {status, datas}
  ```

  where `status` can be either `:ok` or `:error` and `datas` being the result
  of the function, the client was expecting to receive on call.
  """

  alias Db.Absence.Provider
  alias Absence.Public.Requests

  @doc """
  Returns a list of absences

  # Expected return value:
  ```
  %{ data: %{ absence: [%Absence{}] } }
  ```

  # Absence struct
  Absence struct should contains the fields defined by `wished_fields`
  """
  def all() do
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    Provider.reply(:absence_provider, Requests.all(wished_fields))
  end

  @doc """
  # TODO
  """
  def find(id) do
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    Provider.reply(:absence_provider, Requests.get(id, wished_fields))
  end

  @doc """
  # TODO
  """
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

  @doc """
  # TODO
  """
  def update(id, absence_params) do
    id = String.to_integer(id)
    wished_fields = ["id", "kind", "status", "begin_on", "end_on"]

    # TODO use guard instead of case
    case Absence.Public.Validators.valid_absence?(absence_params) do
      true ->
        Provider.reply(:absence_provider, Requests.update(id, absence_params, wished_fields))
      false ->
        {:ok, %{error: "invalid absence params"} }
    end
  end

  @doc """
  # TODO
  """
  def delete(id) do
    Provider.reply(:absence_provider, Requests.delete(id))
  end
end
