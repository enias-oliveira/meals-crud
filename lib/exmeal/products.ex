defmodule Exmeal.Products do
  alias Exmeal.Error

  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Exmeal.Repo

  alias Exmeal.Meal

  @doc """
  Returns the list of meals.

  ## Examples

      iex> list_meals()
      [%Meal{}, ...]

  """
  def list_meals do
    Repo.all(Meal)
  end

  @doc """
  Gets a single meal.

  Raises `Ecto.NoResultsError` if the Meal does not exist.

  ## Examples

      iex> get_meal!(123)
      %Meal{}

      iex> get_meal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meal!(id), do: Repo.get!(Meal, id)

  @doc """
  Creates a meal.

  ## Examples

      iex> create_meal(%{field: value})
      {:ok, %Meal{}}

      iex> create_meal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meal(attrs \\ %{}) do
    case %Meal{}
         |> Meal.changeset(attrs)
         |> Repo.insert() do
      {:error, result} -> {:error, Error.build(:bad_request, result)}
      response -> response
    end
  end

  @doc """
  Updates a meal.

  ## Examples

      iex> update_meal(meal, %{field: new_value})
      {:ok, %Meal{}}

      iex> update_meal(meal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meal(%{"id" => id} = attrs) do
    try do
      id
      |> get_meal!()
      |> Meal.changeset(attrs)
      |> Repo.update()
    rescue
      _ in Ecto.NoResultsError -> {:error, %Error{status: :not_found, result: "Meal not found"}}
    end
  end

  @doc """
  Deletes a meal.

  ## Examples

      iex> delete_meal(meal)
      {:ok, %Meal{}}

      iex> delete_meal(meal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meal(id) do
    try do
      get_meal!(id) |> Repo.delete()
    rescue
      _ in Ecto.NoResultsError -> {:error, %Error{status: :not_found, result: "Meal not found"}}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meal changes.

  ## Examples

      iex> change_meal(meal)
      %Ecto.Changeset{data: %Meal{}}

  """
  def change_meal(%Meal{} = meal, attrs \\ %{}) do
    Meal.changeset(meal, attrs)
  end

  def get_meal_by_id(id) do
    try do
      {:ok, get_meal!(id)}
    rescue
      _ in Ecto.NoResultsError -> {:error, %Error{status: :not_found, result: "Meal not found"}}
    end
  end
end
