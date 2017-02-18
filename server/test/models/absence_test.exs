defmodule Server.AbsenceTest do
  use Server.ModelCase

  alias Server.Absence

  @valid_attrs %{begin_on: %{day: 17, month: 4, year: 2010}, end_on: %{day: 17, month: 4, year: 2010}, half_day: true, kind: "some content", status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Absence.changeset(%Absence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Absence.changeset(%Absence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
