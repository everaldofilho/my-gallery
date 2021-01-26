# controllers/upload_controller.ex
defmodule ApiGalleryUploadWeb.UploadController do
  use ApiGalleryUploadWeb, :controller
  alias ApiGalleryUpload.Upload

  action_fallback(ApiGalleryUploadWeb.FallbackController)

  def create(conn, %{"image" => _} = upload_params) do
    with {:ok, result} <- Upload.upload(upload_params) do
      conn
      |> put_status(:ok)
      |> render("upload.json", data: result)
    end
  end
end
