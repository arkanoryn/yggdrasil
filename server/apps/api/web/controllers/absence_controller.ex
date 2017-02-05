defmodule Api.AbsenceController do
  use Api.Web, :controller

  def index(conn, _params) do
    {:ok, absences} = Absence.all()

    render(conn, "datas.json", datas: absences)
  end

  def create(conn, %{"absence" => absence_params}) do
    {:ok, absence} = Absence.create(absence_params)

    render(conn, "datas.json", datas: absence)
  end

  def show(conn, %{"id" => id}) do
    {:ok, absence} = Absence.find(id)

    render(conn, "datas.json", datas: absence)
  end

  def update(conn, %{"id" => id, "absence" => absence_params}) do
    {:ok, absence} = Absence.update(id, absence_params)

    render(conn, "datas.json", datas: absence)
  end

  def delete(conn, %{"id" => id}) do
    { :ok, _absence } = Absence.destroy(id)

    render(conn, "datas.json", datas: %{data: %{deletion: "success"}})
  end

  defp allow_cors(conn), do: put_resp_header(conn, "Access-Control-Allow-Origin", "*")
end
