defmodule LoggerApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :timestamp, :naive_datetime
      add :identity, :string
      add :table, :string
      add :database, :string
      add :query, :string

      timestamps(type: :utc_datetime)
    end
  end
end
