defmodule ApiGalleryUpload.ClientGallery do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://api-gallery:4000"
  plug Tesla.Middleware.JSON

  plug Tesla.Middleware.FormUrlencoded,
    encode: &Plug.Conn.Query.encode/1,
    decode: &Plug.Conn.Query.decode/1

  def register_image(gallery_id, title, url) do
    params = %{
      "gallery_id" => gallery_id,
      "title" => title,
      "url" => url
    }
    case post("api/images", params) do
      {:error, %{body: body}} -> {:error, body}
      {:ok, %{body: %{"image" => image}}} ->  {:ok, image}
      {:ok, %{body: body}} ->  {:error, body}
    end
  end
end
