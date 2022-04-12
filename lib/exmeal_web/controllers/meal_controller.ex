defmodule ExmealWeb.MealController do
  use ExmealWeb, :controller

  alias Exmeal.Products
  alias Exmeal.Meal

  action_fallback ExmealWeb.FallbackController

  def index(conn, _params) do
    meals = Products.list_meals()
    render(conn, "index.json", meals: meals)
  end

  def create(conn, %{"meal" => meal_params}) do
    with {:ok, %Meal{} = meal} <- Products.create_meal(meal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.meal_path(conn, :show, meal))
      |> render("show.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    meal = Products.get_meal!(id)
    render(conn, "show.json", meal: meal)
  end

  def update(conn, %{"id" => id, "meal" => meal_params}) do
    meal = Products.get_meal!(id)

    with {:ok, %Meal{} = meal} <- Products.update_meal(meal, meal_params) do
      render(conn, "show.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    meal = Products.get_meal!(id)

    with {:ok, %Meal{}} <- Products.delete_meal(meal) do
      send_resp(conn, :no_content, "")
    end
  end
end
