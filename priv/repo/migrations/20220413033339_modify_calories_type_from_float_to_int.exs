defmodule Exmeal.Repo.Migrations.ModifyCaloriesTypeFromFloatToInt do
  use Ecto.Migration

  def change do
    alter table("meals") do
      modify :calories, :integer
    end
  end
end
