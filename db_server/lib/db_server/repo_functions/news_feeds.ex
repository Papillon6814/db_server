defmodule DbServer.RepoFunctions.NewsFeeds do
  @moduledoc """
    The news feeds context.
  """
  use DbServer.AroundRepo

  def create(params, %Game{} = game) do
    %NewsFeed{}
    |> NewsFeed.changeset(params)
    |> add_game_relation(game)
    |> Repo.insert()
  end

  def update(news_feed, params) do
    news_feed
    |> NewsFeed.changeset(params)
    |> Repo.update()
  end

  def delete(news_feed) do
    Repo.delete(news_feed)
  end

  def get(id) do
    Repo.get!(NewsFeed, id)
  end

  # Except for CRUD.
  defp add_game_relation(news_feed, game) do
    game
    |> Game.build_news_feed_assoc(news_feed.changes)
  end
end