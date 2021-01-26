defmodule ApiGalleryWeb.GalleryController do
  use ApiGalleryWeb, :controller
  alias ApiGallery.Service.Gallery

  action_fallback ApiGalleryWeb.FallbackController

  def index(conn, _params) do

    with gallerys <- Gallery.search() do
      conn
      |> put_status(:ok)
      |> render("data.json", data: gallerys)
    end
  end


  def create(conn, params) do
    with {:ok, gallery} <- Gallery.create(params) do
      conn
        |> put_status(:created)
        |> render("create.json",  %{data: gallery})
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, gallery} <- Gallery.update(id, params) do
      conn
        |> put_status(:ok)
        |> render("update.json",  %{data: gallery})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, gallery} <- Gallery.fetch(id) do
      conn
        |> put_status(:ok)
        |> render("show.json",  %{data: gallery})
    end
  end

end
