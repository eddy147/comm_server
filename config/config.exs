import Config

config :comm_server, CommServer.Messages.Repo,
  database: "commserver",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

IO.inspect(Mix.env())

import_config("#{Mix.env}.exs")
