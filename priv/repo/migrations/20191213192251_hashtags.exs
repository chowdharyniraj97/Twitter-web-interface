defmodule Rumbl.Repo.Migrations.Hashtags do
  use Ecto.Migration

  def change do
    create table(:hashtags) do
      add :hashtag, :string, null: false
      add :tweet, :string
      add :username, :string
      timestamps
    end
  end
end
