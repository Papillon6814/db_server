defmodule DbServer.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
