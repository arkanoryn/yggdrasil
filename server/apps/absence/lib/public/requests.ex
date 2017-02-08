defmodule Absence.Public.Requests do
  @moduledoc """
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
  def format_list(fields_list) do
    Enum.join(fields_list, "\n")
  end
end
