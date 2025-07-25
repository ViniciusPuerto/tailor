# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tailor_api,
  ecto_repos: [TailorApi.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :tailor_api, TailorApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: TailorApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TailorApi.PubSub,
  live_view: [signing_salt: "ewVw+6u/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :tailor_api, TailorApi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure Guardian (JWT) and Ecto migrations defaults
config :tailor_api, TailorApi.Guardian,
  issuer: "tailor_api",
  secret_key: "V/B6Mzzyu8sP52c1ngPjRo90Hj4WMGYhetqIk3AfAtZGCPXL5wNNDJLnRehnl2Zd"

config :tailor_api, TailorApi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
