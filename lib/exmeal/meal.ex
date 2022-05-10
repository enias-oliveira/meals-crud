defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :calories, :date, :description]}

  schema "meals" do
    field(:calories, :integer)
    field(:date, :date)
    field(:description, :string)
    belongs_to(:user, Exmeal.User)

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:description, :date, :calories])
    |> validate_required([:description, :date, :calories])
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:description, :date, :calories])
    |> validate_required([:description, :date, :calories])
  end
end
