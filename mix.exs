defmodule CommServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :comm_server,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {CommServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.5"},
      {:cowboy, "~> 2.8"},
      {:plug, "~> 1.11"},
      {:plug_cowboy, "~> 2.4"},
      {:sweet_xml, "~> 0.6.6"},
      {:zstream, "~> 0.5.2"},
      {:xml_builder, "~> 2.1"}
    ]
  end
end
