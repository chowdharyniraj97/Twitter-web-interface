defmodule Rumbl.Repo.Migrations.Followers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      add :username, :string, null: false
      add :fan, :string
      timestamps
  end
end
end
