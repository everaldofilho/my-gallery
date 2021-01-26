defmodule ApiGalleryUpload.ClientAws do

  defp send_s3(:test, _bucket_folder, _file_name, _image_binary), do: {:ok, "success"}

  defp send_s3(_env, bucket_folder, file_name, image_binary) do
    ExAws.S3.put_object(bucket_folder, file_name, image_binary, [
      {:acl, :public_read},
      {:content_type, "image/png"}
    ])
    |> ExAws.request()
  end

  def send_bucket(image) do
    file_uuid = Ecto.UUID.generate()
    image_filename = String.replace(image.filename, ~r"[^a-zA-Z\-\.]", "")
    unique_filename = "#{file_uuid}-#{image_filename}"
    bucket_name = System.get_env("BUCKET_NAME")
    folder = "teste-v2"
    with {:ok, image_binary} <- File.read(image.path),
         {:ok, _reason} <- send_s3(Mix.env(), folder, unique_filename, image_binary) do
      {:ok, "https://#{bucket_name}.s3.amazonaws.com/#{folder}/#{unique_filename}"}
    end
  end
end
