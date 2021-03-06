import Config

config :comm_server, CommServer.Messages.Repo,
  database: "commserver",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

IO.puts("You are in #{Mix.env()} mode")

import_config("#{Mix.env()}.exs")
