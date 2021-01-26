defmodule ClientAws do

  defp send_s3(bucket_folder, file_name, image_binary) do
    ExAws.S3.put_object(bucket_folder, file_name, image_binary, [
      {:acl, :public_read},
      {:content_type, "image/png"}
    ])
    |> ExAws.request()
  end

  def send_bucket(path, unique_filename) do
    bucket_name = System.get_env("BUCKET_NAME")
    folder = "teste-v2"
    with {:ok, image_binary} <- File.read(path),
         {:ok, _reason} <- send_s3(folder, unique_filename, image_binary) do
      {:ok, "https://#{bucket_name}.s3.amazonaws.com/#{folder}/#{unique_filename}"}
    end
  end
end
