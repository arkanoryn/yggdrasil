defmodule Absence do
  use Ecto.Schema

  schema "absences" do
    field :kind, :integer
    field :status, :integer
    field :begin_on, Timex.Ecto.Date
    field :end_on, Timex.Ecto.Date
    field :half_day, :boolean, default: false
  end

  def start(type, args) do
    Absence.Application.start(type, args)
  end

  def mock do
    %{ kind: 1,
       status: 2
    }
  end
end
