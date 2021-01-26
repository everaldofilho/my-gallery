use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api_gallery_upload, ApiGalleryUploadWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :tesla, adapter: Tesla.Mock


config :ex_aws,
  access_key_id: "123123132",
  secret_access_key: "123sad3as21d3as21d3as8as9da9s8d",
  s3: [
    scheme: "https://",
    host: "criativoweb-bucket.s3.amazonaws.com",
    region: "us-east-2"
  ]
