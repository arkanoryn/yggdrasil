defmodule Db.Absence.Resolver do
  use Timex
  require Logger

  def all(_args, _info) do
    {:ok, Db.Repo.all(Db.Absence.Model)}
  end

  def find(%{ id: id }, _info) do
    {:ok, Db.Repo.get!(Db.Absence.Model, id)}
  end

  def create(args, _info) do
    args = clean_args(args)

    %Db.Absence.Model{}
    |> Db.Absence.Model.changeset(args)
    |> Db.Repo.insert
  end

  def update(%{id: id, absence: absence_params}, _info) do
    absence_params = clean_args(absence_params)

    Db.Repo.get!(Db.Absence.Model, id)
    |> Db.Absence.Model.changeset(absence_params)
    |> Db.Repo.update
  end

  def delete(%{id: id}, _info) do
    Db.Repo.get!(Db.Absence.Model, id)
    |> Db.Repo.delete
  end

  defp clean_args(args) do
    args = if Map.has_key?(args, :begin_on) do
      %{args | begin_on: clean_date(args.begin_on)}
    else
      args
    end
    args = if Map.has_key?(args, :end_on) do
      %{args | end_on: clean_date(args.end_on)}
    else
      args
    end
    args
  end

  defp clean_date(date_string) do
    date_string
    |> Timex.parse!("%Y-%m-%d", :strftime)
    |> Timex.to_date
  end
end
