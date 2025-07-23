defmodule TailorApiWeb.AuthErrorHandler do
  @moduledoc """
  Handles authentication errors triggered by Guardian plugs.
  Responds with a 401 JSON payload describing the error.
  """

  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = %{error: to_string(type)}

    conn
    |> put_status(:unauthorized)
    |> json(body)
    |> halt()
  end
end
