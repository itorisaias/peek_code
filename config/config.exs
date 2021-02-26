# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :peek_code,
  ecto_repos: [PeekCode.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :peek_code, PeekCodeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gq4DW3z2ywfFDFo+Cxv2SWQW5RdQgyOqPnIhB4jLg5IxyTK2Z1HCsZxP5zr1KHsq",
  render_errors: [view: PeekCodeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PeekCode.PubSub,
  live_view: [signing_salt: "lhBCK0/9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
