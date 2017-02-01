defmodule Db.Absence do
  use Ecto.Schema

  schema "absences" do
    field :kind, :integer
  end

  def mock do
    "Hi"
  end
end
