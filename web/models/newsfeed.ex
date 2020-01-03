defmodule Rumbl.NewsFeed do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

    schema "newsfeed" do
      field :username, :string
      field :feed, :string

      timestamps()
    end
def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:username, :feed])
  |> validate_required([:username, :feed])
end
def get_messages(limit \\ 20) do
  IO.inspect :current_user
  Rumbl.Repo.all(Rumbl.NewsFeed)
end

end
