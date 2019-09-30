use Mix.Config

# Configure your database
config :bynk_loany, BynkLoany.Repo,
  username: "postgres",
  password: "postgres",
  database: "bynk_loany_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bynk_loany, BynkLoanyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
