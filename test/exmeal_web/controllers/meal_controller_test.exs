defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase

  alias Exmeal.Products
  alias Exmeal.Products.Meal

  @create_attrs %{
    calories: 120.5,
    date: ~D[2010-04-17],
    description: "some description"
  }
  @update_attrs %{
    calories: 456.7,
    date: ~D[2011-05-18],
    description: "some updated description"
  }
  @invalid_attrs %{calories: nil, date: nil, description: nil}

  def fixture(:meal) do
    {:ok, meal} = Products.create_meal(@create_attrs)
    meal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all meals", %{conn: conn} do
      conn = get(conn, Routes.meal_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create meal" do
    test "renders meal when data is valid", %{conn: conn} do
      conn = post(conn, Routes.meal_path(conn, :create), meal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.meal_path(conn, :show, id))

      assert %{
               "id" => id,
               "calories" => 120.5,
               "date" => "2010-04-17",
               "description" => "some description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meal_path(conn, :create), meal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meal" do
    setup [:create_meal]

    test "renders meal when data is valid", %{conn: conn, meal: %Meal{id: id} = meal} do
      conn = put(conn, Routes.meal_path(conn, :update, meal), meal: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.meal_path(conn, :show, id))

      assert %{
               "id" => id,
               "calories" => 456.7,
               "date" => "2011-05-18",
               "description" => "some updated description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, meal: meal} do
      conn = put(conn, Routes.meal_path(conn, :update, meal), meal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meal" do
    setup [:create_meal]

    test "deletes chosen meal", %{conn: conn, meal: meal} do
      conn = delete(conn, Routes.meal_path(conn, :delete, meal))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.meal_path(conn, :show, meal))
      end
    end
  end

  defp create_meal(_) do
    meal = fixture(:meal)
    %{meal: meal}
  end
end
