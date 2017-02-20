defmodule Server.AbsenceController do
  use Server.Web, :controller
  use Guardian.Phoenix.Controller

  alias Server.Absence

  @kinds ["disease", "vacation", "special_leave"]
  @statuses ["accepted", "refused", "pending", "canceled"]

  def index(conn, _params, user, _claims) do
    absences =
      Ecto.assoc(user, :absences)
      |> Repo.all

    render(conn, "index.json", absences: absences)
  end

  def create(conn, %{"absence" => absence_params}, user, _claims) do
    absence_params = Map.put(absence_params, "status", "pending")

    case valid_absence?(absence_params) do
      true ->
        changeset =
          user
          |> build_assoc(:absences)
          |> Absence.changeset(absence_params)

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
      false ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Server.ChangesetView, "error.json", changeset: "invalid date/kind")
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

  # TODO - write doc
  def valid_absence?(%{"kind" => kind, "begin_on" => begin_on, "end_on" => end_on, "status" => status}) do
    valid_kind?(kind) && valid_dates?(begin_on, end_on) && valid_status?(status)
  end

  # TODO - write doc
  @spec valid_kind?(String.t) :: boolean
  def valid_kind?(kind) do
    Enum.member?(@kinds, kind)
  end

  # TODO - write doc
  @spec valid_status?(String.t) :: boolean
  def valid_status?(status) do
    Enum.member?(@statuses, status)
  end

  # TODO - write doc
  # TODO - test the functionality
  @spec valid_dates?(String.t, String.t) :: boolean
  def valid_dates?(begin_on, end_on) do
    begin_on = to_date(begin_on)
    end_on = to_date(end_on)

    Timex.compare(Timex.today, begin_on) <= 0 &&
    (Timex.compare(begin_on, end_on) == 0 || Timex.before?(begin_on, end_on))
  end

  # TODO - write doc
  @spec to_date(String.t) :: Date.t
  def to_date(date) do
    date
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.to_date
  end
end
