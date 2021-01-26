# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config
# Configure your database
config :api_gallery, ApiGallery.Repo,
  username: "root",
  password: "root",
  database: "api_gallery_dev",
  hostname: "gallery-db",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configures the endpoint
config :api_gallery, ApiGalleryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Oq2dmspsjKyp21Do8Nst9XTP8GYj5C6eYNZwWFn/Ce0AICnZ6rD5lSP/jrUK4P5s",
  render_errors: [view: ApiGalleryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiGallery.PubSub,
  live_view: [signing_salt: "8YkKynH1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
