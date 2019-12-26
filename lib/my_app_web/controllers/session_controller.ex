defmodule MyAppWeb.SessionController do
  use MyAppWeb, :controller

  alias MyApp.Auth

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> put_view(MyAppWeb.SessionView)
        |> render("sign_in.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> put_view(MyAppWeb.ErrorView)
        |> render("401.json", message: message)
    end
  end
end
