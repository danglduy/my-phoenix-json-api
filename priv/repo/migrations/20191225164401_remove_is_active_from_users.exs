defmodule MyApp.Repo.Migrations.RemoveIsActiveFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :is_active
    end
  end
end
