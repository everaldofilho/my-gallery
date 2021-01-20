defmodule ApiGallery.Service.Gallery do
  alias ApiGallery.{Repo, Schema}
  alias Schema.Gallery, as: GallerySchema
  alias ApiGallery.Util
  def search() do
    Repo.all(GallerySchema)
    |> Repo.preload(:images)
  end

  def fetch(id) do
    with {:ok, id} <- Util.valid_uuid(id)  do
      case Repo.get(GallerySchema, id) do
        nil -> {:error, :not_found}
        gallery -> {:ok, handle_fetch(gallery)}
      end
    end
  end

  def create(params) do
    changeset = GallerySchema.changeset(%GallerySchema{}, params)

    Repo.insert(changeset)
    |> handle_create()
  end

  def update(id, params) do
    with {:ok, id} <- Util.valid_uuid(id) do
      Repo.get(GallerySchema, id)
      |> handle_update(params)
    end
  end

  defp handle_create({:error, changeset}), do: {:error, changeset}

  defp handle_create({:ok, gallery}) do
    gallery =
      gallery
      |> Repo.preload(:images)

    {:ok, gallery}
  end

  defp handle_update(nil, _params), do: {:error, "Gallery not found"}

  defp handle_update(gallery, params) do
    changeset = GallerySchema.changeset(gallery, params)

    with {:ok, gallery} <- Repo.update(changeset) do
      gallery =
        gallery
        |> Repo.preload(:images)

      {:ok, gallery}
    end
  end

  defp handle_fetch(gallery) do
    gallery
    |> Repo.preload(:images)
  end
end
