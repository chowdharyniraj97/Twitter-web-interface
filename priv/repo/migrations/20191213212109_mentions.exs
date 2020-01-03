defmodule Rumbl.Repo.Migrations.Mentions do
  use Ecto.Migration

  def change do
    create table(:mentions) do
      add :username, :string, null: false
      add :mention_username, :string
      add :tweet, :string
      timestamps
    end
  end
end
