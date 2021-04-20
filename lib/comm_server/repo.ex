defmodule CommServer.Repo do
  use Ecto.Repo,
    otp_app: :comm_server,
    adapter: Ecto.Adapters.Postgres
end
