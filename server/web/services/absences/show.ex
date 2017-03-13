defmodule Server.Services.Absences.Show do
  alias Server.Absence
  alias Server.Repo

  def user_absences(user) do
    Ecto.assoc(user, :absences)
    |> Repo.all
  end

  def all_accepted() do
    Absence
    |> Absence.accepted
    |> Absence.with_user
    |> Repo.all
  end
end
