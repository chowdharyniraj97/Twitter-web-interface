defmodule Rumbl.User do
  use Rumbl.Web, :model
  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps
  end

  def changeset(model, params \\ :empty) do
  model
  |> cast(params, ~w(name username), [])
  |> validate_length(:username, min: 1, max: 20)
  |> cast(params, ~w(password_hash password), [])
  |> validate_length(:password, min: 6, max: 100)
  end

  def registration_changeset(model, params) do
  model
  |> changeset(params)
  |> cast(params, ~w(password), [])
  |> validate_length(:password, min: 6, max: 100)
  |> put_pass_hash()
  end


  defp put_pass_hash(changeset) do
    case changeset do
       %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
       put_change(changeset, :password_hash, pass)
       _ ->
       changeset
   end
 end


end
