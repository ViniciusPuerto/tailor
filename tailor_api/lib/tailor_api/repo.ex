defmodule TailorApi.Repo do
  use Ecto.Repo,
    otp_app: :tailor_api,
    adapter: Ecto.Adapters.Postgres
end
