defmodule LoggerApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LoggerApiWeb.Telemetry,
      LoggerApi.Repo,
      {DNSCluster, query: Application.get_env(:logger_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LoggerApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LoggerApi.Finch},
      # Start a worker by calling: LoggerApi.Worker.start_link(arg)
      # {LoggerApi.Worker, arg},
      # Start to serve requests, typically the last entry
      LoggerApiWeb.Endpoint
      # add this line
      # {Absinthe.Subscription, LoggerApiWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LoggerApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LoggerApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
