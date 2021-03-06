defmodule DbServerWeb.TournamentSchemaTest do
  use ExUnit.Case, async: true
  # XXX: I dunno why I'm using DbServer.DataCase
  use DbServer.DataCase
  use DbServer.AroundRepo

  describe "tournament schema test." do
    @insert_params %{
      name: "test_name",
      duration: 120,
      participation_deadline: DateTime.utc_now(),
      team_number_limit: 2,
      player_number_limit: 2
    }

    @update_params %{
      name: "updated_one"
    }

    @insert_game_params %{
      name: "test_name"
    }

    @update_game_params %{
      name: "new_one"
    }

    test "crud test." do
      assert {_, struct} = Tournaments.create(@insert_params)
      assert %Tournament{} = tournament = Tournaments.get(struct.id)
      assert @insert_params.name == tournament.name
      assert {:ok, %Tournament{} = tournament} = Tournaments.update(tournament, @update_params)
      assert @update_params.name == tournament.name
      assert {:ok, %Tournament{} = tournament} = Tournaments.delete(tournament)
    end

    test "relation with a game test." do
      assert {_, game_struct} = Games.create(@insert_game_params)
      assert {_, tournament_struct} = Tournaments.create(@insert_params, game_struct)

      assert game = Games.get(tournament_struct.game_id)
      assert @insert_game_params.name == game.name

      assert _ = Games.update(game, @update_game_params)
      game = Games.get(tournament_struct.game_id)
      assert @update_game_params.name == game.name

      assert {:ok, %Tournament{} = tournament} = Tournaments.delete(tournament_struct)
    end
  end
end