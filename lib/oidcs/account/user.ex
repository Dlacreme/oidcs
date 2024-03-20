defmodule OIDCS.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset_sign_up(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_hash, :first_name, :last_name])
    |> validate_length(:password, min: 8, max: 72)
    |> hash_password()
    |> validate_required([:email, :password_hash, :first_name, :last_name])
  end

  defp hash_password(changeset) do
    password =
      get_change(changeset, :password)

    if is_binary(password) do
      changeset
      |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end
end
