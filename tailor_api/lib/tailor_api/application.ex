defmodule TailorApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TailorApiWeb.Telemetry,
      TailorApi.Repo,
      {DNSCluster, query: Application.get_env(:tailor_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TailorApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TailorApi.Finch},
      # Start a worker by calling: TailorApi.Worker.start_link(arg)
      # {TailorApi.Worker, arg},
      # Start to serve requests, typically the last entry
      TailorApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TailorApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TailorApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
