# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :cubesem_server, CubesemServer.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "NIcZc1Esh6FzM5DHE5aRaPUOA0IlXknDnv9dOwMiFnw+bXLCmkusiuo6SRQiPbfh",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: CubesemServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :logger,
  backends: [{LoggerLogstashBackend, :error_log}, :console]

config :logger, :error_log,
  host: "localhost",
  port: 10001,
  level: :warn,
  type: "cubesem_log"
