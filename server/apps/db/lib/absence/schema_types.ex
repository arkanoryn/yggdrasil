defmodule Db.Absence.Schema.Types do
  use Timex
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Db.Repo

  scalar :time, description: "ISOz time" do
    # TODO = Parse is not working. Maybe find a way to fix it?
    parse fn(x) -> (Timex.parse!(x, "%Y-%m-%d", :strftime) |> Timex.to_date) end
    serialize &(Timex.format!(&1, "%Y-%m-%d", :strftime))
  end

  object :absence do
    field :id, :id
    field :kind, :string
    field :status, :string
    field :begin_on, :time
    field :end_on, :time
  end

  object :absence_str do
    field :id, :id
    field :kind, :string
    field :status, :string
    field :begin_on, :string
    field :end_on, :string
  end

  input_object :update_absence_params do
    field :kind, :string
    field :begin_on, :string
    field :end_on, :string
  end

  input_object :update_absence_status do
    field :status, non_null(:string)
  end
end
