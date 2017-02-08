defmodule Absence.Public.Requests do
  @moduledoc ~S"""
  Define GraphQL Requests that will be send to the DB interface

  Read http://graphql.org/learn/ for further information regarding GraphQL syntax


  # Arguments
  All requests should receive a `list` of fields they wish to retrieve from the
  database

  Each item of the list must be a `String.t`
  """

  @doc """
  # TODO
  """
  def all(fields_list) do
    """
    {
      absences
      {
        #{format_list(fields_list)}
      }
    }
    """
  end

  @doc """
  # TODO
  """
  def get(id, fields_list) do
    """
    {
      absence(id: #{id})
      {
        #{format_list(fields_list)}
      }
    }
    """
  end

  @doc """
  # TODO
  """
  def update(id, params, fields_list) do
    """
    mutation UpdateAbsence {
      update_absence(id: #{id},
                     absence: {
                       #{ Enum.map(params, fn({key, value}) -> "#{key}: \"#{value}\"," end ) }
                     })
      {
        #{format_list(fields_list)}
      }
    }
    """
  end

  @doc """
  # TODO
  """
  def create(params, fields_list) do
    """
    mutation CreateAbsence {
      create_absence (#{ Enum.map(params, fn({key, value}) -> "#{key}: \"#{value}\"," end ) })
      {
        #{format_list(fields_list)}
      }
    }
    """
  end

  @doc """
  # TODO
  """
  def delete(id) do
    """
    mutation DeleteAbsence {
      delete_absence(id: #{id})
      {
        id
      }
    }
    """
  end

  @spec format_list(list(String.t)) :: String.t
  defp format_list(fields_list) do
    Enum.join(fields_list, "\n")
  end
end
