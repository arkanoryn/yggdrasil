defmodule Server.Services.Absences.Create do
  alias Server.Absence
  alias Server.Repo

  require IEx
  def user_absence(user, params) do
    params = Map.put(params, "status", "pending")

    case Server.Services.Absences.Validator.validate_absence(params) do
      {:ok, _}            -> create(user, params)
      {:error, _, errors} -> {:error, errors}
      _                   -> raise "Unpredicted result."
    end
  end

  defp create(user, params) do
    user
    |> Ecto.build_assoc(:absences)
    |> Absence.changeset(params)
    |> Repo.insert
  end
end
