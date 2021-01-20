defmodule ApiGallery.Schema.Image do
  alias ApiGallery.Schema.Gallery
  use Ecto.Schema
  import Ecto.Changeset

  @require [:gallery_id, :url, :title]
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  @derive {Jason.Encoder, only: [:id, :title, :url, :updated_at, :inserted_at, :gallery_id]}

  schema "image" do
    field(:title, :string)
    field(:url, :string)
    belongs_to(:gallery, Gallery)
    timestamps()
  end

  def changeset(schema, params) do
    schema
    |> cast(params, @require)
    |> validate_required(@require)
    |> assoc_constraint(:gallery)
  end
end
