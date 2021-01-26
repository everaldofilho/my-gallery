defmodule ApiGalleryUpload.ClientGalleryTest do
  use ExUnit.Case, async: true
  import Tesla.Mock
  alias ApiGalleryUpload.ClientGallery
  @base_url "http://api-gallery:4000"
  describe "register_image/1" do
    test "request error" do
      mock(fn %{
                method: :post,
                url: @base_url <> "/api/images"
              } ->
        %Tesla.Env{status: 400, body: %{"errors" => %{"gallery" => ["does not exist"]}}}
      end)

      result =
        ClientGallery.register_image(
          Ecto.UUID.generate(),
          "Title",
          "http://teste.com.br/teste.png"
        )

      assert {:error, %{"errors" => %{"gallery" => ["does not exist"]}}} = result
    end
    test "request success" do
      mock(fn %{
                method: :post,
                url: @base_url <> "/api/images"
              } ->
        %Tesla.Env{status: 200, body: %{"image" => %{
          "id" => "123456",
          "url" => "http://teste.com.br/teste.jpg",
          "title" => "title"
          }}}
      end)

      result =
        ClientGallery.register_image(
          Ecto.UUID.generate(),
          "Title",
          "http://teste.com.br/teste.png"
        )

      assert {:ok, %{"id" => "123456", "title" => "title"}} = result
    end
  end
end
