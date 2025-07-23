defmodule TailorApiWeb.AuthController do
  use TailorApiWeb, :controller
  alias TailorApi.Accounts
  alias TailorApi.Guardian

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        json(conn, %{token: token, user: %{id: user.id, email: user.email}})
      :error ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end
end
