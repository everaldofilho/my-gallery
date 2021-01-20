defmodule ApiGallery.Repo.Migrations.Gallery do
  use Ecto.Migration

  def change do
    create table(:gallery, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 100
      timestamps()
    end
  end
end
