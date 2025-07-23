defmodule TailorApiWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use TailorApiWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # The default endpoint for testing
      @endpoint TailorApiWeb.Endpoint

      use TailorApiWeb, :verified_routes

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import TailorApiWeb.ConnCase

      # Helper to add Authorization header with a valid JWT for the given user (or a new user)
      @spec auth_conn(Plug.Conn.t(), TailorApi.Accounts.User.t() | nil) :: Plug.Conn.t()
      def auth_conn(conn, user \\ nil) do
        user =
          case user do
            nil ->
              {:ok, user} = TailorApi.Accounts.register_user(%{email: "test_#{System.unique_integer()}@example.com", password: "password123"})
              user
            user -> user
          end

        {:ok, token, _claims} = TailorApi.Guardian.encode_and_sign(user)
        Plug.Conn.put_req_header(conn, "authorization", "Bearer #{token}")
      end
    end
  end

  setup tags do
    TailorApi.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
