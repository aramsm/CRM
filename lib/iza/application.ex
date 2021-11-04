defmodule Iza.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Iza.Repo,
      # Start the Telemetry supervisor
      IzaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Iza.PubSub},
      # Start the Endpoint (http/https)
      IzaWeb.Endpoint
      # Start a worker by calling: Iza.Worker.start_link(arg)
      # {Iza.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Iza.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IzaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
