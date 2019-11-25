defmodule DbServer.RepoFunctions.Users do
  @moduledoc """
    The users context.
  """
  use DbServer.AroundRepo

  def create_user(params \\ :empty) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def delete_user(user \\ %{}) do
    Repo.delete(user)
  end

  def get_user(id \\ :empty) do
    Repo.get!(User, id)
  end

  # Except for CRUD.

  def add_game_relation(user \\ %{}, game \\ %{}) do
    user
    |> Repo.preload([:game])
    |> User.assoc_changeset(game)
  end

  def update_user(changeset) do
    changeset
    |> Repo.update()
  end
end