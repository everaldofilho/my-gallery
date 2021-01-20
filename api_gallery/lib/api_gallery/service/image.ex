defmodule ApiGallery.Service.Image do
  alias ApiGallery.{Repo, Schema}
  alias Schema.Image, as: ImageSchema
  alias ApiGallery.Util

  def search() do
    Repo.all(ImageSchema)
  end

  def create(params) do
    %ImageSchema{}
    |> ImageSchema.changeset(params)
    |> Repo.insert()
  end

  def update(id, params) do
    with {:ok, gallery} <- fetch_id(id) do
      gallery
      |> ImageSchema.changeset(params)
      |> Repo.update()
    end
  end

  def fetch_id(id) do
    with {:ok, uuid} <- Util.valid_uuid(id) do
      case Repo.get(ImageSchema, uuid) do
        nil -> {:error, :not_found}
        gallery -> {:ok, gallery}
      end
    end
  end

  def remove(id) do
    with {:ok, gallery} <- fetch_id(id) do
      Repo.delete(gallery)
    end
  end
end
