# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :api_gallery_upload, ApiGalleryUploadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vhQl9MFrL33iCBSwKjcVhF8q1wErxL/5Ovf1jgl4JOEjQUnPXJ8+Erbu19zRDRHi",
  render_errors: [view: ApiGalleryUploadWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiGalleryUpload.PubSub,
  live_view: [signing_salt: "bdO2nR5A"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure :ex_aws

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3: [
    scheme: "https://",
    host: "criativoweb-bucket.s3.amazonaws.com",
    region: "us-east-2"
  ]

config :tesla, adapter: Tesla.Adapter.Hackney


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
