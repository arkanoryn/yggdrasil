defmodule AbsenceTest do
  use ExUnit.Case
  doctest Absence

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "get all absence from DB" do
    { :ok, absences } = (Absence.all)
    absences = absences.data

    assert Map.has_key?(absences, "absences")
    assert Enum.count(absences["absences"]) > 0
  end

  test "find absence by id" do
    { :ok, absence } = Absence.find(1)
    absence = absence.data

    assert Map.has_key?(absence, "absence")
    assert absence["absence"]["id"] == "1"
  end

  test "create absence" do
    abs_params = %{
      "kind"     =>"vacation",
      "status"   => "pending",
      "begin_on" => Timex.format!(Timex.today, "%Y-%m-%d", :strftime),
      "end_on"   => Timex.format!(Timex.shift(Timex.today, days: 3),  "%Y-%m-%d", :strftime)
    }

    assert {:ok, _} = Absence.create(abs_params)
  end

  test "update absence" do
    abs_params = %{
      "kind"     =>"disease"
    }

    assert {:ok, _} = Absence.update("1", abs_params)
  end

  test "delete absence" do
    assert {:ok, _} = Absence.destroy(1)
  end
end
