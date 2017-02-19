defmodule Server.User do
  use Server.Web, :model

  import Comeonin.Bcrypt, only: [checkpw: 2]

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :absences, Server.Absence

    timestamps()
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> put_pass_hash()
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> put_pass_hash()
  end

  def find_and_confirm_password(%{"username" => username, "password" => password}) do
    user = Server.Repo.get_by(Server.User, username: username)

    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, user}
      true ->
        {:error, "not found"}
    end
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
