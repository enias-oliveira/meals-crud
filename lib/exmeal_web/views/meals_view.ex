defmodule ExmealWeb.MealsView do
  use ExmealWeb, :view
  alias ExmealWeb.MealsView
  alias Exmeal.Meal

  def render("index.json", %{meals: meal}) do
    %{data: render_many(meal, MealsView, "meal.json")}
  end

  def render("show.json", %{meals: meal}) do
    render_one(meal, MealsView, "meal.json")
  end

  def render("create.json", %{meal: meal}) do
    %{meal: render_one(meal, MealsView, "meal.json"), message: "Meal created!"}
  end

  def render("meal.json", %{meals: meal}) do
    %{
      meal: %Meal{
        id: meal.id,
        description: meal.description,
        date: meal.date,
        calories: meal.calories
      }
    }
  end

  def render("meal.json", %{meal: meal}), do: render("meal.json", %{meals: meal})
end
