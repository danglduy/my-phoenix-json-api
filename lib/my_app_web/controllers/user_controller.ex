defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Auth
  alias MyApp.Auth.User

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"users" => users}) do
    with {:ok, %{} = inserted_users_map} <- Auth.create_users(users) do
      conn
      |> put_status(:created)
      |> render("index.json", users: inserted_users_map |> Map.values())
    else
      {:error, failed_index, %Ecto.Changeset{} = changeset, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error_create_users.json",
          failed_index: failed_index,
          changeset: changeset
        )
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"users" => user_ids}) do
    users = user_ids |> Enum.map(& &1["id"])

    with {:ok, %{}} <- Auth.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
