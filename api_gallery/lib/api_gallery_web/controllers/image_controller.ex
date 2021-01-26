defmodule ApiGalleryWeb.ImageController do
  use ApiGalleryWeb, :controller
  alias ApiGallery.Service.Image

  action_fallback(ApiGalleryWeb.FallbackController)

  def index(conn, _params) do
    conn
    |> render("index.json", data: Image.search())
  end

  def create(conn, params) do
    with {:ok, image} <- Image.create(params) do
      conn
      |> render("create.json", data: image)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, image} <- Image.update(id, params) do
      conn
      |> render("update.json", data: image)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, image} <- Image.fetch_id(id) do
      conn
      |> render("show.json", data: image)
    end
  end
end
