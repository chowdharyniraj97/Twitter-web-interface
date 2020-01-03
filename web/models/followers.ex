defmodule Rumbl.Followers do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

schema "followers" do
    field :username, :string
    field :fan, :string
    timestamps()
end

def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:username, :fan])
  |> validate_required([:username, :fan])
end
def get_followers(limit \\ 20) do
  Rumbl.Repo.all(Rumbl.Followers)
end

end
