defmodule MyAppWeb.ErrorView do
  use MyAppWeb, :view

  def render("400.json", %{message: message}) do
    %{status: "400", errors: [%{detail: message}]}
  end

  def render("401.json", %{message: message}) do
    %{status: "401", errors: [%{detail: message}]}
  end

  def render("500.json", _assigns) do
    %{status: "500", errors: [%{detail: "Internal Server Error"}]}
  end

  def template_not_found(template, _assigns) do
    %{
      errors: %{
        detail: Phoenix.Controller.status_message_from_template(template)
      }
    }
  end
end
