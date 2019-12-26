defmodule MyAppWeb.UserView do
  use MyAppWeb, :view
  alias MyAppWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "_user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "_user.json")}
  end

  def render("_user.json", %{user: user}) do
    %{id: user.id, email: user.email}
  end
end
