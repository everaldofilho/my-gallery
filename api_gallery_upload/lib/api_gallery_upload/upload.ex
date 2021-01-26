defmodule ApiGalleryUpload.Upload do
  alias ApiGalleryUpload.ClientGallery
  alias ApiGalleryUpload.ClientAws
  alias ApiGalleryUpload.ClientQueue

  def upload(%{
        "gallery_id" => gallery_id,
        "image" => file
      }) do

        Enum.map(file, fn f ->
          {:ok, binary}  =  File.read(f.path)

          ClientQueue.send(%{
            "gallery_id": gallery_id,
            "image_source": Base.encode64(binary),
            "image_name": f.filename
            })
        end)

      {:ok, %{success: "teset"}}
  end
end
