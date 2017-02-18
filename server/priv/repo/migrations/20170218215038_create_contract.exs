defmodule Server.Repo.Migrations.CreateContract do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :year, :date
      add :vacation_days, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:contracts, [:user_id])

  end
end
