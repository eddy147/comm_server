import Config

config :comm_server, CommServer.Repo,
  database: "comm_server",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :comm_server,
  ecto_repos: [CommServer.Repo]

if File.exists?("config/#{Mix.env()}.exs") do
  import_config("#{Mix.env()}.exs")
end
