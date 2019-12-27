# Source from user @alg on https://elixirforum.com/t/generating-constraint-error-messages/15037

defmodule MyAppWeb.Errors do
  def full_messages(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&full_message/3)
    |> Enum.flat_map(&elem(&1, 1))
  end

  defp full_message(%Ecto.Changeset{} = changeset, key, error) do
    module_name = inspect(changeset.data.__struct__)
    key_path = "#{module_name}.#{key}"

    key_name =
      case Gettext.dgettext(MyAppWeb.Gettext, "schema", key_path) do
        ^key_path -> Phoenix.Naming.humanize(key)
        n -> n
      end

    "#{key_name} #{MyAppWeb.ErrorHelpers.translate_error(error)}"
  end
end
