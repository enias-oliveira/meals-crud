defmodule ExmealWeb.UserController do
  use ExmealWeb, :controller

  alias Exmeal.Accounts
  alias Exmeal.User

  action_fallback(ExmealWeb.FallbackController)

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("create_user.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    case Accounts.get_user_by_id(id) do
      {:ok, user} -> render(conn, "show.json", user: user)
      error -> error
    end
  end

  def update(conn, update_params) do
    with {:ok, %User{} = user} <- Accounts.update_user(update_params) do
      render(conn, "user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Accounts.delete_user(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
