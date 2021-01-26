defmodule ApiGalleryUploadWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(400)
    |> put_view(ApiGalleryUploadWeb.ErrorView)
    |> render("400.json", result: result)
  end

end
