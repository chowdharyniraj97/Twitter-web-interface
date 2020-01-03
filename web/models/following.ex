defmodule Rumbl.Following do
    use Rumbl.Web, :model
use Ecto.Schema
import Ecto.Changeset
import Ecto.Query

schema "following" do
    field :username, :string
    field :foll, :string
    timestamps()
end

def changeset(model, params \\ %{}) do
  model
  |> cast(params,[:username, :foll])
  |> validate_required([:username, :foll])
end
  def get_following(limit \\ 20) do
    Rumbl.Repo.all(Rumbl.following)
  end

end
