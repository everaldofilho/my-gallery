defmodule ApiGallery.Service.ImageTest do
  use ApiGallery.DataCase
  alias ApiGallery.Service.Image
  alias ApiGallery.Service.Gallery

  setup do
    {:ok, %{id: gallery_id}} = Gallery.create(%{"name" => "My gallery"})
    {:ok, %{id: image_id}} = Image.create(%{"title" => "My image", "url"=> "http://teste.com.br", "gallery_id" => gallery_id})
    {:ok, gallery_id: gallery_id, image_id: image_id}
  end

  describe "saerch/0" do
    test "all data" do
      result = Image.search()
      assert [
        %ApiGallery.Schema.Image{}
      ] = result
    end
  end

  describe "create/1" do
    test "image create faild, fields required" do
      result = Image.create(%{})

      assert {:error,
              %Ecto.Changeset{
                valid?: false,
                errors: [
                  gallery_id: {"can't be blank", [validation: :required]},
                  url: {"can't be blank", [validation: :required]},
                  title: {"can't be blank", [validation: :required]}
                ]
              }} = result
    end

    test "image create faild, id invalid" do
      result = Image.create(%{"gallery_id" => Ecto.UUID.generate(), "url" => "http://teste.com.br", "title" => "My image" })

      assert {:error, %Ecto.Changeset{
        valid?: false,
        errors: [
          gallery: {"does not exist", _season}
        ]
      }} = result
    end
    test "image create with sucesso", %{gallery_id: gallery_id} do
      result = Image.create(%{"gallery_id" => gallery_id, "url" => "http://teste.com.br", "title" => "My image" })

      assert {:ok, %ApiGallery.Schema.Image{}} = result
    end
  end

  describe "update/2" do
    test "faild update, not found image" do
      result = Image.update(Ecto.UUID.generate(), %{"url" => "http://teste.com.br/image.jpg"})

      assert {:error, :not_found} = result
    end

    test "faild update, url no blank", %{image_id: image_id} do
      result = Image.update(image_id, %{"url" => ""})

      assert {:error, %Ecto.Changeset{
        valid?: false,
        errors: [url: {"can't be blank", [validation: :required]}]
      }} = result
    end

    test "update success", %{image_id: image_id} do
      result = Image.update(image_id, %{"url" => "http://teste.com.br"})

      assert {:ok, %ApiGallery.Schema.Image{
        url: "http://teste.com.br"
      }} = result
    end
  end


  describe "remove/1" do
    test "faild remove, not found image" do
      result = Image.remove(Ecto.UUID.generate())

      assert {:error, :not_found} = result
    end

    test "remove sucesso", %{image_id: image_id} do
      result = Image.remove(image_id)
      assert {:ok, gallery} = result
    end

    # test "update success", %{image_id: image_id} do
    #   result = Image.update(image_id, %{"url" => "http://teste.com.br"})

    #   assert {:ok, %ApiGallery.Schema.Image{
    #     url: "http://teste.com.br"
    #   }} = result
    # end
  end
end
