defmodule Rumbl.Repo.Migrations.Following do
  use Ecto.Migration

  def change do
    create table(:following) do
      add :username, :string, null: false
      add :foll, :string
      timestamps
    end
  end
end
