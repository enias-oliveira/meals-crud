defmodule ExmealWeb.UserView do
  use ExmealWeb, :view
  alias ExmealWeb.UserView
  alias Exmeal.User

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{user: %User{id: user.id, name: user.name, cpf: user.cpf, email: user.email}}
  end

  def render("create.json", %{user: user}) do
    %{
      user: %User{id: user.id, name: user.name, cpf: user.cpf, email: user.email},
      message: "User created!"
    }
  end

  def render("create_user.json", %{user: user}) do
    %{
      user: %{
        user: %User{id: user.id, name: user.name, cpf: user.cpf, email: user.email},
      },
      message: "User created!"
    }
  end
end
