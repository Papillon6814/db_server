defmodule DbServerWeb.ParticipatingTeamSchemaTest do
  use ExUnit.Case, async: true
  use DbServer.DataCase
  use DbServer.AroundRepo

  describe "participating team schema test." do
    @insert_tournament_params %{
      name: "test_name",
      duration: 120,
      participation_deadline: DateTime.utc_now(),
      team_number_limit: 2,
      player_number_limit: 2
    }

    @insert_user_params %{
      id: "test_id",
      name: "test_name",
      email: "email@gmail.com",
      password: "Password123?",
      gender: 0,
      bio: "Howdy?",
      birthday: DateTime.utc_now()
    }

    @update_user_params %{
      name: "new_one"
    }

    test "team creation and adding member test." do
      assert {_, tournament_struct} = Tournaments.create_tournament(@insert_tournament_params)
      assert {_, participating_team_struct} = ParticipatingTeams.create_participating_team(tournament_struct)

      # get the tourney.
      assert %ParticipatingTeam{} = participating_team = ParticipatingTeams.get_participating_team(participating_team_struct.id)
      assert {_, user_struct} = Users.create_user(@insert_user_params)
      assert {:ok, %ParticipatingTeam{} = participating_team} = ParticipatingTeams.add_member_relation(participating_team, user_struct)
                                                                |> ParticipatingTeams.update_participating_team()
      tmp_user = participating_team.user
                 |> hd()
      
      assert @insert_user_params.id == tmp_user.id

      assert {:ok, %User{} = user} = Users.update_user(tmp_user, @update_user_params)
      assert %ParticipatingTeam{} = participating_team = ParticipatingTeams.get_participating_team(participating_team_struct.id)

      tmp_user = participating_team.user
                 |> hd()

      assert user.name == tmp_user.name
    end
  end
end