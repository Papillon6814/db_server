defmodule DbServerWeb.TournamentSchemaTest do
  use ExUnit.Case, async: true
  # XXX: I dunno why I'm using DbServer.DataCase
  use DbServer.DataCase

  alias DbServer.Tournaments
  alias DbServer.Schema.Tournament

  describe "tournament schema test." do
    @insert_params %{
      tournament_name: "test_name",
      tournament_duration: 120,
      tournament_participation_deadline: DateTime.utc_now(),
      team_number_limit: 2,
      player_number_limit: 2
    }

    @update_params %{
      tournament_name: "updated_one"
    }

    test "crud test." do
      assert {_, struct} = Tournaments.create_tournament(@insert_params)
      assert %Tournament{} = tournament = Tournaments.get_tournament(struct.id)
      assert {:ok, %Tournament{} = tournament} = Tournaments.update_tournament(tournament, @update_params)
      assert {:ok, %Tournament{} = tournament} = Tournaments.delete_tournament(tournament)
    end
  end
end