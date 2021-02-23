defmodule CommServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    port = 4001

    children = [
      {Plug.Cowboy, scheme: :http, plug: CommServer.Router, options: [port: port]},
      {CommServer.Messages.Repo, [name: CommServer.Messages.Repo]}
    ]

    Logger.info("\n🎧  Listening for connection requests on port #{port}...\n")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CommServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
