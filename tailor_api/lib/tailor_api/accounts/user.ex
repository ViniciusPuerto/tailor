defmodule TailorApi.Accounts.User do
  use Ecto.Schema

  # Use UUIDs (binary_id) as primary and foreign keys to align with database migrations
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :orders, TailorApi.Orders.Order
    has_many :created_orders, TailorApi.Orders.Order, foreign_key: :created_by

    timestamps()
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
    end
  end
end
