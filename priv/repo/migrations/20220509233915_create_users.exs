defmodule Exmeal.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string
      add :cpf, :string
      add :email, :string
      add(:user_id, references(:users))

      timestamps()
    end

  end
end
