defmodule ApiGallery.Repo.Migrations.Image do
  use Ecto.Migration

  def change do
    create table("image", primary_key: false) do
      add :id, :uuid, primary_key: true
      add :url, :string
      add :title, :string
      add :gallery_id, references(:gallery, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end
