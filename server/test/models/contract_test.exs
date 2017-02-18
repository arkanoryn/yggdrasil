defmodule Server.ContractTest do
  use Server.ModelCase

  alias Server.Contract

  @valid_attrs %{vacation_days: 42, year: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Contract.changeset(%Contract{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Contract.changeset(%Contract{}, @invalid_attrs)
    refute changeset.valid?
  end
end
