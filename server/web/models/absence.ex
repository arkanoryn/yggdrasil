defmodule Server.Absence do
  use Server.Web, :model

  schema "absences" do
    field :kind, :string
    field :status, :string
    field :begin_on, Timex.Ecto.Date
    field :end_on, Timex.Ecto.Date
    field :half_day, :boolean, default: false
    belongs_to :user, Server.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:kind, :status, :begin_on, :end_on, :user_id])
    |> validate_required([:kind, :status, :begin_on, :end_on, :user_id])
  end

  def with_user(query) do
    from q in query, preload: :user
  end

  def accepted(query) do
    from q in query, where: q.status == "accepted"
  end
end
