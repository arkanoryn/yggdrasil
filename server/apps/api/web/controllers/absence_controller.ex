defmodule Api.AbsenceController do
  use Api.Web, :controller

  def index(conn, _params) do
    {:ok, absences} = Absence.Public.Actions.all()

    render(conn, "datas.json", datas: absences)
  end

  def create(conn, %{"absence" => absence_params}) do
    {:ok, absence} = Absence.Public.Actions.create(absence_params)

    render(conn, "datas.json", datas: absence)
  end

  def show(conn, %{"id" => id}) do
    {:ok, absence} = Absence.Public.Actions.find(id)

    render(conn, "datas.json", datas: absence)
  end

  def update(conn, %{"id" => id, "absence" => absence_params}) do
    {:ok, absence} = Absence.Public.Actions.update(id, absence_params)

    render(conn, "datas.json", datas: absence)
  end

  def delete(conn, %{"id" => id}) do
    { :ok, _absence } = Absence.Public.Actions.destroy(id)

    render(conn, "datas.json", datas: %{data: %{deletion: "success"}})
  end
end
