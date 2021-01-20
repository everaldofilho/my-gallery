defmodule ApiGalleryWeb.ImageView do
  use ApiGalleryWeb, :view

  def render("show.json", %{data: data}) do
    %{image: data}
  end

  def render("update.json", %{data: data}) do
    %{message: "Updated", image: data}
  end

  def render("create.json", %{data: data}) do
    %{message: "Created", image: data}
  end

  def render("index.json", %{data: data}) do
    %{data: data}
  end
end
