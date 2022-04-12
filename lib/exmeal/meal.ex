defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "meals" do
    field :calories, :float
    field :date, :date
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:description, :date, :calories])
    |> validate_required([:description, :date, :calories])
  end
end
