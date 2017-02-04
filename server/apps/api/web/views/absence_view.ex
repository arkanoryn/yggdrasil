defmodule Api.AbsenceView do
  use Api.Web, :view

  def render("datas.json", %{datas: datas}) do
    datas
  end

  def render("test_msg.json", %{absences: absence}) do
    %{ data: %{ msg: absence } }
  end

  def render("index.json", %{absences: absences}) do
    %{data: render_many(absences, Api.AbsenceView, "absence.json")}
  end

  def render("show.json", %{absence: absence}) do
    %{data: render_one(absence, Api.AbsenceView, "absence.json")}
  end

  def render("absence.json", %{absence: absence}) do
    %{id: absence.id,
      kind: absence.kind}
  end
end
