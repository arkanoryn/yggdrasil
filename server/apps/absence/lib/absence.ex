defmodule Absence do
  alias Db.Absence.Provider

  @type kind :: :vacation | :disease | :special_leave
  @type status :: :pending | :granted | :refused | :canceled

  def start(type, args) do
    Absence.Application.start(type, args)
  end

  def all() do
    Provider.reply(:absence_provider, all_request())
  end

  def find(id) do
    Provider.reply(:absence_provider, get_request(id))
  end

  def create(absence_params) do
    Provider.reply(:absence_provider, creation_request(absence_params))
  end

  def update(id, absence_params) do
    id = String.to_integer(id)

    Provider.reply(:absence_provider, update_request(id, absence_params))
  end

  def destroy(id) do
    Provider.reply(:absence_provider, delete_request(id))
  end

  def all_request do
    """
    {
      absences {
        #{expected_return_fields(fields_list(["id"]))}
      }
    }
    """
  end

  defp get_request(id) do
    """
    {
      absence(id: #{id}) {
        #{expected_return_fields(fields_list(["id"]))}
      }
    }
    """
  end

  defp update_request(id, params) do
    """
    mutation UpdateAbsence {
      update_absence (
        id: #{id},
        absence: {
          #{ Enum.map(params, fn({key, value}) -> "#{key}: \"#{value}\"," end ) }
        }
      )
      {
        #{expected_return_fields(fields_list())}
      }
    }
    """
  end

  defp creation_request(params) do
    """
    mutation CreateAbsence {
      create_absence (
        #{ Enum.map(params, fn({key, value}) -> "#{key}: \"#{value}\"," end ) }
      )
      {
        #{ expected_return_fields( fields_list(["id"]) ) }
      }
    }
    """
  end

  defp delete_request(id) do
    """
    mutation DeleteAbsence {
      delete_absence(id: #{id})
      {
        id
      }
    }
    """
  end

  @spec fields_list(list(String.t)) :: list
  defp fields_list(extra_fields \\ []) do
    extra_fields ++ ["kind", "status", "begin_on", "end_on"]
  end

  @spec expected_return_fields(list(String.t)) :: String.t
  defp expected_return_fields(fields) do
    Enum.join(fields, "\n")
  end
end
