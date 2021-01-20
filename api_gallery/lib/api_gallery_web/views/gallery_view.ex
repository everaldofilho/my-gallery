defmodule ApiGalleryWeb.GalleryView do
  use ApiGalleryWeb, :view

  def render("show.json", %{data: data}) do
    %{
      gallery: data
    }
  end

  def render("update.json", %{data: data}) do
    %{
      message: "Gallery updated with success",
      gallery: data
    }
  end

  def render("create.json", %{data: data}) do
    %{
      message: "Gallery created with success",
      gallery: data
    }
  end

  def render("data.json", %{data: data}) do
    %{data: data}
  end
end
