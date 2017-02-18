defmodule Server.Contract do
  use Server.Web, :model

  schema "contracts" do
    field :year, Ecto.Date
    field :vacation_days, :integer
    belongs_to :user, Server.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:year, :vacation_days])
    |> validate_required([:year, :vacation_days])
  end
end
