import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :logger_api, LoggerApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "logger_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :logger_api, LoggerApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "0rK35Xh7vcKn/RSc4ypmcXFuabi9S76K1RkZq1oSfxGn63po4ITlYNEMh4+Sn9rJ",
  server: false

# In test we don't send emails.
config :logger_api, LoggerApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
