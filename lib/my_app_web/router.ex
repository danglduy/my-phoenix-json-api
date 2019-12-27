defmodule MyAppWeb.Router do
  use MyAppWeb, :router
  alias MyAppWeb.ErrorView

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", MyAppWeb do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create
      post "/sessions", SessionController, :create
    end

    scope "/v1" do
      pipe_through [:api_auth]
      delete "/sessions", SessionController, :delete
      resources "/users", UserController, except: [:new, :edit]
    end
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(ErrorView)
      |> render("401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
