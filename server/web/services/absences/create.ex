defmodule Server.Services.Absences.Create do
  alias Server.Absence
  alias Server.Repo

  def user_absence(user, params) do
    params = Map.put(params, "status", "pending")

    case Server.Services.Absences.Validator.validate_absence(params) do
      {:ok, _}            ->
        create(user, params)
        |> send_creation_email(user, Server.Services.Users.Admins.list(:email))
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

  defp send_creation_email({:ok, absence}, user, admins) do
    Server.Services.Emails.Absence.on_create({absence, user}, admins)
    |> Server.Services.Mailers.LocalMailer.deliver_later

    {:ok, absence}
  end
  defp send_creation_email(res, _user, _admins), do: res
end
