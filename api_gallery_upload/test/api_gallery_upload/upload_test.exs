defmodule ApiGalleryUpload.UploadTest do
  use ExUnit.Case, async: true
  alias ApiGalleryUpload.Upload
  import Tesla.Mock
  describe "upload/1" do
    test "success" do
      mock(fn %{
              method: :post
            } ->
      %Tesla.Env{status: 200, body: %{"image" => %{
        "id" => "123456",
        "url" => "http://teste.com.br/teste.jpg",
        "title" => "title"
        }}}
      end)
      result = Upload.upload(%{
        "gallery_id" => "rwaw",
        "image" => %{filename: "test_helper.jpeg", path: "/app/test/test_helper.exs"}
      })
      expected = {:ok, %{"id" => "123456", "title" => "title", "url" => "http://teste.com.br/teste.jpg"}}
      assert expected == result
    end
  end
end
