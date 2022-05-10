defmodule Exmeal.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :cpf, :email, :name, :meals]}

  schema "users" do
    field(:cpf, :string)
    field(:email, :string)
    field(:name, :string)
    has_many(:meals, Exmeal.Meal)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :email])
    |> validate_required([:name, :cpf, :email])
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:name, :cpf, :email])
    |> validate_required([:name, :cpf, :email])
  end
end
