defmodule ExmealWeb.UsersViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  import Exmeal.Factory

  alias Exmeal.User

  alias ExmealWeb.UserView

  test "render create.json" do
    user_params = build(:users_params)

    {:ok, %User{id: id} = user} = Exmeal.create_user(user_params)

    response = render(UserView, "create.json", user: user)

    assert %{
             user: %User{
               cpf: "12345678900",
               name: "Jp",
               email: "jp@banana.com",
               id: ^id
             },
             message: "User created!"
           } = response
  end

  test "render user.json" do
    user_params = build(:users_params)

    {:ok, %User{id: id} = user} = Exmeal.create_user(user_params)

    response = render(UserView, "user.json", user: user)

    assert %{
             user: %User{
               cpf: "12345678900",
               name: "Jp",
               email: "jp@banana.com",
               id: ^id
             }
           } = response
  end
end
