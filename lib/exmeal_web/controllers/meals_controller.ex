defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller

  alias Exmeal.Products
  alias Exmeal.Meal
  alias Exmeal.Error

  action_fallback(ExmealWeb.FallbackController)

  def index(conn, _params) do
    meals = Products.list_meals()
    render(conn, "index.json", meals: meals)
  end

  def create(conn, meal_params) do
    with {:ok, %Meal{} = meal} <- Products.create_meal(meal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.meals_path(conn, :show, meal))
      |> render("create.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      meal = Products.get_meal!(id)
      render(conn, "show.json", meals: meal)
    rescue
      _ in Ecto.NoResultsError -> {:error, %Error{status: :not_found, result: "Meal not found"}}
    end
  end

  def update(conn, %{"id" => id} = meal_params) do
    attrs = Map.get(meal_params, "meal", %{})

    with {:ok, %Meal{} = meal} <-
           Products.update_meal(Map.put(attrs, "id", id)) do
      render(conn, "show.json", meals: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- Products.delete_meal(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
