defmodule Exmeal.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :description, :string
      add :date, :date
      add :calories, :float

      timestamps()
    end

  end
end
