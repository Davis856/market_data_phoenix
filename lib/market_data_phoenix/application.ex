defmodule MarketDataPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MarketDataPhoenixWeb.Telemetry,
      # Start the Ecto repository
      MarketDataPhoenix.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MarketDataPhoenix.PubSub},
      # Start Finch
      {Finch, name: MarketDataPhoenix.Finch},
      # Start the Endpoint (http/https)
      MarketDataPhoenixWeb.Endpoint
      # Start a worker by calling: MarketDataPhoenix.Worker.start_link(arg)
      # {MarketDataPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MarketDataPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MarketDataPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
