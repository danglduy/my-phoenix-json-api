defmodule MyAppWeb.UserView do
  use MyAppWeb, :view
  alias MyAppWeb.UserView
  alias MyAppWeb.ErrorHelpers

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("error_create_users.json", %{
        failed_index: index,
        changeset: changeset
      }) do
    %{
      status: "422",
      failed_index: index,
      failed_email: changeset.changes.email,
      errors: changeset |> ErrorHelpers.mapped_messages()
    }
  end
end
