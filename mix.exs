defmodule NsukiBusinessService.MixProject do
  use Mix.Project

  def project do
    [
      app: :nsuki_business_service,
      version: "0.1.0",
      elixir: "~> 1.10.3",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NsukiBusinessService.Application, []},
      extra_applications: [:logger, :runtime_tools, :ueberauth_google, :con_cache, :ssl]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.14"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, "~> 2.1"},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:ueberauth, "~> 0.6.3"},
      {:ueberauth_google, "~> 0.8"},
      {:guardian, "~> 2.1"},
      {:con_cache, "~> 0.14.0"},
      {:bamboo, "~> 1.4"},
      {:cors_plug, "~> 2.0"},
      {:google_api_calendar, "~> 0.17"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
