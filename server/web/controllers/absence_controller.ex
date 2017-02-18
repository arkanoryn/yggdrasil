defmodule Server.AbsenceController do
  use Server.Web, :controller

  alias Server.Absence

  def index(conn, _params) do
    absences = Repo.all(Absence)
    render(conn, "index.json", absences: absences)
  end

  def create(conn, %{"absence" => absence_params}) do
    changeset = Absence.changeset(%Absence{}, absence_params)

    case Repo.insert(changeset) do
      {:ok, absence} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", absence_path(conn, :show, absence))
        |> render("show.json", absence: absence)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ChangesetView, "error.json", changeset: changeset)
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
end
