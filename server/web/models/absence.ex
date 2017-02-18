defmodule Server.Absence do
  use Server.Web, :model

  schema "absences" do
    field :kind, :string
    field :status, :string
    field :begin_on, Timex.Ecto.Date
    field :end_on, Timex.Ecto.Date
    field :half_day, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:kind, :status, :begin_on, :end_on])
    |> validate_required([:kind, :status, :begin_on, :end_on])
  end
end
