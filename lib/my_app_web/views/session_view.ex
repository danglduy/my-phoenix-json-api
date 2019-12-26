defmodule MyAppWeb.SessionView do
  use MyAppWeb, :view
  alias MyAppWeb.SessionView

  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email
        }
      }
    }
  end
end
