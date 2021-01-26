defmodule ImageTreatment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ImageTreatmentWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImageTreatment.PubSub},
      # Start the Endpoint (http/https)
      ImageTreatmentWeb.Endpoint
      # Start a worker by calling: ImageTreatment.Worker.start_link(arg)
      # {ImageTreatment.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImageTreatment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ImageTreatmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
