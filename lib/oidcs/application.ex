defmodule OIDCS.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OIDCSWeb.Telemetry,
      OIDCS.Repo,
      {DNSCluster, query: Application.get_env(:oidcs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OIDCS.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: OIDCS.Finch},
      # Start a worker by calling: OIDCS.Worker.start_link(arg)
      # {OIDCS.Worker, arg},
      # Start to serve requests, typically the last entry
      OIDCSWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OIDCS.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OIDCSWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
