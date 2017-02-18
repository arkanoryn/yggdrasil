defmodule Server.AbsenceView do
  use Server.Web, :view

  def render("index.json", %{absences: absences}) do
    %{data: %{ absences: render_many(absences, Server.AbsenceView, "absence.json") }}
  end

  def render("show.json", %{absence: absence}) do
    %{data: render_one(absence, Server.AbsenceView, "absence.json")}
  end

  def render("absence.json", %{absence: absence}) do
    %{
      id:       to_string(absence.id),
      kind:     absence.kind,
      status:   absence.status,
      begin_on: absence.begin_on,
      end_on:   absence.end_on
    }
  end
end
