defmodule DbTest do
  use ExUnit.Case
  doctest Db

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "get the message" do
    assert Db.Absence.mock() == "Hi"
  end
end
