defmodule CommServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :comm_server,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def aliases() do
    [
      test: "test --no-start"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug, :eex],
      mod: {CommServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.6.1"},
      {:plug, "~> 1.11.1"},
      {:plug_cowboy, "~> 2.5.0"},
      {:postgrex, ">= 0.15.8"},
      {:quinn, "~> 1.1.3"},
      {:sweet_xml, "~> 0.6.6"},
      {:zstream, "~> 0.6.0"}
    ]
  end
end
