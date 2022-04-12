defmodule ExmealWeb.MealView do
  use ExmealWeb, :view
  alias ExmealWeb.MealView

  def render("index.json", %{meals: meals}) do
    %{data: render_many(meals, MealView, "meal.json")}
  end

  def render("show.json", %{meal: meal}) do
    %{data: render_one(meal, MealView, "meal.json")}
  end

  def render("meal.json", %{meal: meal}) do
    %{id: meal.id,
      description: meal.description,
      date: meal.date,
      calories: meal.calories}
  end
end
