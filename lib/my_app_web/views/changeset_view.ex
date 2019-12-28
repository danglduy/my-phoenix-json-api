defmodule MyAppWeb.ChangesetView do
  use MyAppWeb, :view

  alias MyAppWeb.ErrorHelpers

  def render("error.json", %{changeset: changeset}) do
    %{status: "422", errors: changeset |> ErrorHelpers.mapped_messages()}
  end
end
