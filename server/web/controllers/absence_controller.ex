defmodule Server.AbsenceController do
  use Server.Web, :controller
  use Guardian.Phoenix.Controller

  alias Server.Absence

  def all_accepted(conn, _params, _user, _claims) do
    absences = Server.Services.Absences.Show.all_accepted

    render(conn, "public_index.json", absences: absences)
  end

  def index(conn, _params, user, _claims) do
    absences = Server.Services.Absences.Show.user_absences(user)

    render(conn, "index.json", absences: absences)
  end

  def create(conn, %{"absence" => absence_params}, user, _claims) do
    case Server.Services.Absences.Create.user_absence(user, absence_params) do
      {:ok, absence}   ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", absence_path(conn, :show, absence))
        |> render("show.json", absence: absence)
      {:error, errors} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ErrorView, "422.json", errors: errors)
    end
  end

  def show(conn, %{"id" => id}) do
    absence = Repo.get!(Absence, id)
    render(conn, "show.json", absence: absence)
  end

  def update(conn, %{"id" => id, "absence" => absence_params}) do
    absence = Repo.get!(Absence, id)
    changeset = Absence.changeset(absence, absence_params)

    case Repo.update(changeset) do
      {:ok, absence} ->
        render(conn, "show.json", absence: absence)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    absence = Repo.get!(Absence, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(absence)

    send_resp(conn, :no_content, "")
  end

  def unauthenticated(conn, _params) do
    IO.puts "unauthenticated"
    conn
  end

  def unauthorized(conn, _params) do
    IO.puts "unauthorized"
    conn
  end
end
