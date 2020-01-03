defmodule Rumbl.Tweets do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

    schema "tweets" do
      field :username, :string
      field :tweeter, :string
      field :tweet, :string

      timestamps()
    end

def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:username, :tweeter,:tweet])
  |> validate_required([:username, :tweeter,:tweet])
end
def get_tweets(limit \\ 20) do
  # IO.inspect :current_user
  # Rumbl.Repo.all(Rumbl.Tweets)
  from(i in Rumbl.Tweets,
  select: %{ username: i.username, tweeter: i.tweeter, tweet: i.tweet },
  order_by: [desc: i.inserted_at]) |> Rumbl.Repo.all
end

end
