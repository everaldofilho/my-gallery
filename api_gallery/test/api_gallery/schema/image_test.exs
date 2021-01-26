defmodule ApiGallery.Schema.ImageTest do
  use ApiGallery.DataCase
  alias ApiGallery.Schema.Image

  describe "changeset/1" do
    test "all data invalid" do
      result = Image.changeset(%Image{}, %{})

      assert %Ecto.Changeset{
        valid?: false,
        errors: [
          {:gallery_id, {"can't be blank", [validation: :required]}},
          {:url, {"can't be blank", [validation: :required]}},
          {:title, {"can't be blank", [validation: :required]}}
        ]
      } = result


      assert ["can't be blank"] == errors_on(result).url
    end

    test "UUID invalid" do
      result = Image.changeset(%Image{}, %{"gallery_id" => "12313", "url" => "http://teste.com.br", "title"=> "teste"})

      assert %Ecto.Changeset{
        valid?: false,
        errors: [
          {:gallery_id, {"is invalid", [type: Ecto.UUID, validation: :cast]}},
        ]
      } = result

    end

    test "Valid all data" do
      result = Image.changeset(%Image{}, %{
        "gallery_id" => Ecto.UUID.generate(),
        "url" => "http://teste.com.br",
        "title"=> "teste"
        })

      assert %Ecto.Changeset{
        valid?: true
      } = result
    end
  end
end
