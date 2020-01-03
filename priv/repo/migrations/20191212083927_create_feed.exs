defmodule Rumbl.Repo.Migrations.CreateFeed do
  use Ecto.Migration

  def change do
    create table(:newsfeed) do
      add :username, :string, null: false
      add :feed, :string
      timestamps
  end
end
end
