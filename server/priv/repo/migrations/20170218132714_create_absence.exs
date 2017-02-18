defmodule Server.Repo.Migrations.CreateAbsence do
  use Ecto.Migration

  def change do
    create table(:absences) do
      add :kind, :string
      add :status, :string
      add :begin_on, :date
      add :end_on, :date
      add :half_day, :boolean, default: false, null: false

      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

  end
end
