defmodule ApiGallery.Service.GalleryTest do
  use ApiGallery.DataCase
  alias ApiGallery.Service.Gallery

  describe "search/0" do
    test "find all gallery" do
      result = Gallery.search()
      assert result == []
    end
  end

  describe "fetch/1" do
    setup do
      {:ok, %{id: id}} = Gallery.create(%{"name" => "My Gallery Fetch"})
      {:ok, id: id}
    end
    test "find one gallery invalid" do
      result = Gallery.fetch(Ecto.UUID.generate())
      assert {:error, :not_found} = result
    end
    test "find on gallery valid", %{id: id} do
      result = Gallery.fetch(id)
      assert {:ok, gallery} = result
    end
  end

  describe "create/1" do
    test "teste create faild" do
      result = Gallery.create(%{"name" => ""})
      assert {:error, _reason} = result
    end
    test "teste create ok" do
      result = Gallery.create(%{"name" => "My Gallery"})
      assert {:ok, gallery} = result
    end
  end

  describe "update/1" do

    setup do
      {:ok, %{id: id}} = Gallery.create(%{"name" => "My Gallery"})
      {:ok, id: id}
    end

    test "test update not found" do
      result = Gallery.update(Ecto.UUID.generate(), %{"name" => ""})
      assert {:error, "Gallery not found"} = result
    end

    test "test update data invalid", %{id: id} do
      result = Gallery.update(id, %{"name" => ""})
      assert {:error, _reason} = result
    end

    test "test update success", %{id: id} do
      result = Gallery.update(id, %{"name" => "My Gallery 2"})
      assert {:ok, gallery} = result
    end

  end



end
