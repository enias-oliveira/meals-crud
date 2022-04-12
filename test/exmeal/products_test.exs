defmodule Exmeal.ProductsTest do
  use Exmeal.DataCase

  alias Exmeal.Products

  describe "meals" do
    alias Exmeal.Products.Meal

    @valid_attrs %{calories: 120.5, date: ~D[2010-04-17], description: "some description"}
    @update_attrs %{calories: 456.7, date: ~D[2011-05-18], description: "some updated description"}
    @invalid_attrs %{calories: nil, date: nil, description: nil}

    def meal_fixture(attrs \\ %{}) do
      {:ok, meal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_meal()

      meal
    end

    test "list_meals/0 returns all meals" do
      meal = meal_fixture()
      assert Products.list_meals() == [meal]
    end

    test "get_meal!/1 returns the meal with given id" do
      meal = meal_fixture()
      assert Products.get_meal!(meal.id) == meal
    end

    test "create_meal/1 with valid data creates a meal" do
      assert {:ok, %Meal{} = meal} = Products.create_meal(@valid_attrs)
      assert meal.calories == 120.5
      assert meal.date == ~D[2010-04-17]
      assert meal.description == "some description"
    end

    test "create_meal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_meal(@invalid_attrs)
    end

    test "update_meal/2 with valid data updates the meal" do
      meal = meal_fixture()
      assert {:ok, %Meal{} = meal} = Products.update_meal(meal, @update_attrs)
      assert meal.calories == 456.7
      assert meal.date == ~D[2011-05-18]
      assert meal.description == "some updated description"
    end

    test "update_meal/2 with invalid data returns error changeset" do
      meal = meal_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_meal(meal, @invalid_attrs)
      assert meal == Products.get_meal!(meal.id)
    end

    test "delete_meal/1 deletes the meal" do
      meal = meal_fixture()
      assert {:ok, %Meal{}} = Products.delete_meal(meal)
      assert_raise Ecto.NoResultsError, fn -> Products.get_meal!(meal.id) end
    end

    test "change_meal/1 returns a meal changeset" do
      meal = meal_fixture()
      assert %Ecto.Changeset{} = Products.change_meal(meal)
    end
  end
end
