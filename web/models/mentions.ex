defmodule Rumbl.Mentions do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

    schema "mentions" do
      field :username, :string
      field :mention_username, :string
      field :tweet, :string

      timestamps()
  end

def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:username, :mention_username,:tweet])
  |> validate_required([:username, :mention_username,:tweet])
end

def get_mentions(limit \\ 20) do
#  IO.inspect :current_user
  Rumbl.Repo.all(Rumbl.Mentions)
  
end

end
