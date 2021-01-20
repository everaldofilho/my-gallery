defmodule ApiGallery.Repo do
  use Ecto.Repo,
    otp_app: :api_gallery,
    adapter: Ecto.Adapters.MyXQL
end
