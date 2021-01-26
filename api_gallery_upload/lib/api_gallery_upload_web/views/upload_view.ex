defmodule ApiGalleryUploadWeb.UploadView do
  use ApiGalleryUploadWeb,:view

  def render("upload.json", %{data: data}) do
    %{data: data}
  end
end
