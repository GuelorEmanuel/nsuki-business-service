# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nsuki_business_service,
  ecto_repos: [NsukiBusinessService.Repo]

# Configures the endpoint
config :nsuki_business_service, NsukiBusinessServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KEmYqO6ui9s+BWF5P3hP4D4FBXSOk777PcdQpNPtPP3yc6MwCXzUpJFR+Zwiz/1X",
  render_errors: [view: NsukiBusinessServiceWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: NsukiBusinessService.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "zh75NFwx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
