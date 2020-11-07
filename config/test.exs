use Mix.Config

# Configure your database
config :nsuki_business_service, NsukiBusinessService.Repo,
  username: "postgres",
  password: "postgres",
  database: "nsuki_business_service_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nsuki_business_service, NsukiBusinessServiceWeb.Endpoint,
  http: [port: 4002],
  server: false

config :nsuki_business_service,
  google_calendar_service: NsukiBusinessService.MockCalendarServiceBehaviour

# Print only warnings and errors during test
config :logger, level: :warn

if System.get_env("GITHUB_ACTIONS") do
  config :nsuki_business_service, NsukiBusinessService.Repo,
  username: "postgres",
  password: "postgres"
end
