defmodule DbServer.Repo.Migrations.CreateGamesUsers do
  use Ecto.Migration

  def change do
    create table(:games_users) do
      add :game_id, references(:games), on_delete: :delete_all
      add :user_id, references(:users, type: :string), on_delete: :delete_all
    end

    create unique_index(:games_users, [:game_id, :user_id])
  end
end
