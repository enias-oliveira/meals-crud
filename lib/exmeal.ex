defmodule Exmeal do
  alias Exmeal.Products

  defdelegate create_meal(params), to: Products, as: :create_meal
  defdelegate delete_meal(params), to: Products, as: :delete_meal
  defdelegate get_meal_by_id(params), to: Products, as: :get_meal_by_id
  defdelegate update_meal(params), to: Products, as: :update_meal
end
