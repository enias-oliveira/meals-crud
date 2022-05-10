defmodule Exmeal do
  alias Exmeal.Products
  alias Exmeal.Accounts

  defdelegate create_meal(params), to: Products, as: :create_meal
  defdelegate delete_meal(params), to: Products, as: :delete_meal
  defdelegate get_meal_by_id(params), to: Products, as: :get_meal_by_id
  defdelegate update_meal(params), to: Products, as: :update_meal

  defdelegate create_user(params), to: Accounts, as: :create_user
  defdelegate delete_user(params), to: Accounts, as: :delete_user
  defdelegate get_user_by_id(params), to: Accounts, as: :get_user_by_id
  defdelegate update_user(params), to: Accounts, as: :update_user
end
