defmodule TailorApi.Accounts do
  alias TailorApi.Repo
  alias TailorApi.Accounts.User
  import Ecto.Query

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && Argon2.verify_pass(password, user.password_hash) ->
        {:ok, user}
      true ->
        :error
    end
  end

  @doc """
  Fetches a user by ID, raising `Ecto.NoResultsError` if not found.
  Used by Guardian to load the resource from JWT claims.
  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Returns `{:ok, user}` or `:error` depending on whether the user exists.
  """
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> :error
      user -> {:ok, user}
    end
  end
end
