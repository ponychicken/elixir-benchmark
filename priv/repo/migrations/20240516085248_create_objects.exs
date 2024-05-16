defmodule Benchmarking.Repo.Migrations.CreateObjects do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :deleted_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
