defmodule ApiGallery.Schema.Gallery do
  alias ApiGallery.Schema.Image
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @derive {Jason.Encoder,  only: [:id, :name, :images, :updated_at, :inserted_at]}

  schema "gallery" do
    field(:name, :string)
    has_many(:images, Image)
    timestamps()
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
