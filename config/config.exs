import Config

config :comm_server, :randomiser, CommServer.Randomiser

if File.exists?("config/#{Mix.env()}.exs") do
  import_config("#{Mix.env()}.exs")
end
