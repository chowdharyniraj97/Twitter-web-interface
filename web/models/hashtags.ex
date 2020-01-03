defmodule Rumbl.Hashtags do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

    schema "hashtags" do
      field :hashtag, :string
      field :tweet, :string
      field :username, :string

      timestamps()
    end
def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:hashtag, :tweet,:username])
  |> validate_required([:hashtag, :tweet,:username])
end
def get_hashtags(limit \\ 20) do
  IO.inspect :current_user
  Rumbl.Repo.all(Rumbl.Hashtags)
end

end
