defmodule Rumbl.Repo.Migrations.Tweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :username, :string,
      add :tweeter, :string
      add :tweet, :string
      timestamps
    end

  end
end
