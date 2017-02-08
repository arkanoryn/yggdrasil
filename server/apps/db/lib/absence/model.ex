defmodule Db.Absence.Model do
  @moduledoc ~S"""
  Defines Absence Ecto Schema
  """

  use Ecto.Schema

  schema "absences" do
    field :kind, :string
    field :status, :string
    field :begin_on, Timex.Ecto.Date
    field :end_on, Timex.Ecto.Date
    field :half_day, :boolean, default: false

    timestamps()
  end

  def changeset(struct, params \\ :empty) do
    struct
    |> Ecto.Changeset.cast(params, [:kind, :status, :begin_on, :end_on])
    |> Ecto.Changeset.validate_required([:kind, :status, :begin_on, :end_on])
  end
end
