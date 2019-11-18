defmodule DbServer.Schema.Game do
  use Ecto.Schema
  import Ecto.Changeset

  #@primary_key {:game_id, :id, autogenerate: true}

  schema "games" do
    field :game_name, :string

    has_many :following_games, DbServer.Schema.User
    has_one :tournaments_game_id, DbServer.Schema.Tournament

    timestamps()
  end

  def changeset(game, params \\ :empty) do
    game
    |> cast(params, [:game_name])
    |> validate_required(:game_name)
    |> unique_constraint(:game_name, message: "The game already exists.")
  end
end