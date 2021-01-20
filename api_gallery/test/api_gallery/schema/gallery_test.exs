defmodule ApiGallery.Schema.GalleryTest do
  use ApiGallery.DataCase
  alias ApiGallery.Schema.Gallery

  describe "changeset/1" do
    test "invalid name" do
      result = Gallery.changeset(%Gallery{}, %{"name" => nil})

      assert %Ecto.Changeset{
        valid?: false,
        errors: [name: {"can't be blank", [validation: :required]}]
      } = result

      assert ["can't be blank"] == errors_on(result).name
    end

    test "valid name" do
      result = Gallery.changeset(%Gallery{}, %{"name" => "My Gallery"})

      assert %Ecto.Changeset{
        valid?: true,
        errors: []
      } = result

      assert %{} == errors_on(result)
    end
  end
end
