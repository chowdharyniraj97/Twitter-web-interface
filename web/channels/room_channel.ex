defmodule Rumbl.RoomChannel do
  use Phoenix.Channel
import Ecto.Query
  def join("room:lobby", payload, socket) do
  if authorized?(payload) do
    send(self(), :after_join)
    {:ok, socket}
  else
    {:error, %{reason: "unauthorized"}}
  end
end

  def handle_in("new_msg",payload,socket) do
    user =Map.get(payload,"username")
    msg=Map.get(payload,"feed")
    IO.inspect user
    IO.inspect msg
    IO.inspect payload
    #IO.inspect :current_use
    Rumbl.NewsFeed.changeset(%Rumbl.NewsFeed{},payload)|> Rumbl.Repo.insert
    broadcast! socket, "new_msg",payload

    {:noreply,socket}
  end
  def handle_in("addinfollowersfeed",payload,socket) do
    IO.inspect "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    user =Map.get(payload,"username")
    msg=Map.get(payload,"tweet")
    # IO.inspect user
    # IO.inspect msg
    # IO.inspect payload
    #IO.inspect :current_use
    # message="#{user}:#{msg}"
    query=from(follower in Rumbl.Followers,where: follower.username==^user, select: follower.fan)
    result=Rumbl.Repo.all(query)
    result=[user|result]
    IO.inspect result
    Enum.each(result,fn r->
      payload=%{username: r,tweeter: user, tweet: msg}
      Rumbl.Tweets.changeset(%Rumbl.Tweets{},payload)|> Rumbl.Repo.insert
    end)
    broadcast! socket, "addinfollowersfeed",payload
    {:noreply,socket}
  end

  def handle_in("follow",payload,socket) do
    #user =Map.get(payload,"username")
    #msg=Map.get(payload,"feed")
    #IO.inspect user
    #IO.inspect msg
    #IO.inspect payload
    #IO.inspect :current_user

    Rumbl.Followers.changeset(%Rumbl.Followers{},payload)|> Rumbl.Repo.insert
    broadcast! socket, "follow",payload

    {:noreply,socket}
  end

  def handle_in("following",payload,socket) do
    Rumbl.Following.changeset(%Rumbl.Following{},payload)|> Rumbl.Repo.insert
      broadcast! socket, "following",payload
        {:noreply,socket}
  end
  def handle_in("search_hashtag",payload,socket) do
    #hash=Map.get(payload,"hashtag")

    Rumbl.Hashtags.get_hashtags()
    |> Enum.each(fn msg ->
      IO.inspect msg
      push(socket, "search_hashtag", %{

        hashtag: msg.hashtag,
        tweet: msg.tweet,
        username: msg.username
      }) end)
    broadcast! socket, "search_hashtag",payload
      {:noreply,socket}
  end

  def handle_in("search_mention",payload,socket) do
    #hash=Map.get(payload,"hashtag")

    Rumbl.Mentions.get_mentions()
    |> Enum.each(fn msg ->
      IO.inspect msg
      push(socket, "search_mention", %{

        username: msg.username,
        mention_username: msg.mention_username,
        tweet: msg.tweet
      }) end)
    broadcast! socket, "search_mention",payload
      {:noreply,socket}
  end
  def handle_in("deleteaccount",payload,socket) do
    user_name=Map.get(payload,"username")
    from(user in Rumbl.User,where: user.username==^user_name)|>Rumbl.Repo.delete_all
    broadcast! socket, "deleteaccount",payload
      {:noreply,socket}
  end

  def handle_in("addhashtags",payload,socket) do
      Rumbl.Hashtags.changeset(%Rumbl.Hashtags{},payload)|> Rumbl.Repo.insert
      broadcast! socket, "addhashtags",payload
        {:noreply,socket}
  end

  def handle_in("addmentions",payload,socket) do
      Rumbl.Mentions.changeset(%Rumbl.Mentions{},payload)|> Rumbl.Repo.insert
      broadcast! socket, "addmentions",payload
        {:noreply,socket}
  end


  def handle_info(:after_join, socket) do
  Rumbl.Tweets.get_tweets()
  |> Enum.each(fn msg -> push(socket, "addinfollowersfeed", %{

      username: msg.username,
      tweeter: msg.tweeter,
      tweet: msg.tweet
    }) end)

  {:noreply, socket} # :noreply
end
defp authorized?(_payload) do
  true
end

end
