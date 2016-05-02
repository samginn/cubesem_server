use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :my_app, MyApp.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
config :my_app, MyApp.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :my_app, MyApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "dev",
  database: "my_app_dev",
  hostname: "localhost",
  pool_size: 10

config :guardian, Guardian,
  secret_key: "29198054ab8d429bb35b6f519217531ad29a4fe0b738d7cd02883b234a795bcb0d39bc932ebee588256a0b0dbcfea3a29232c7b820bcc454d0dd34e6899b01e7"