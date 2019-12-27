defmodule MyAppWeb.ErrorView do
  use MyAppWeb, :view

  def render("400.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("401.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("422.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error"}}
  end

  def template_not_found(template, _assigns) do
    %{
      errors: %{
        detail: Phoenix.Controller.status_message_from_template(template)
      }
    }
  end
end
