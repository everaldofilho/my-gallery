defmodule ApiGalleryWeb.ImageControllerTest do
  use ApiGalleryWeb.ConnCase
  alias ApiGallery.Service.Image
  alias ApiGallery.Service.Gallery

  setup %{conn: conn} do
    {:ok, %{id: gallery_id}} = Gallery.create(%{"name" => "My gallery"})

    {:ok, conn: conn, gallery_id: gallery_id}
  end

  describe "index" do
    test "not data, ok 200", %{conn: conn} do
      result =
        get(conn, Routes.image_path(conn, :index))
        |> json_response(:ok)

      assert result == %{"data" => []}
    end

    test "One register, ok 200", %{conn: conn, gallery_id: gallery_id} do
      Image.create(%{"title" => "teste", "url" => "http://teste.com.br", "gallery_id" => gallery_id})

      result =
        get(conn, Routes.image_path(conn, :index))
        |> json_response(:ok)

      assert %{
               "data" => [
                 %{
                   "id" => _,
                   "title" => "teste",
                   "url" => "http://teste.com.br",
                   "updated_at" => _
                 }
               ]
             } = result
    end
  end

  describe "create" do
    test "create faild", %{conn: conn} do
      params = %{"name" => ""}

      result =
        post(conn, Routes.image_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"errors" => %{
        "gallery_id" => ["can't be blank"],
        "title" => ["can't be blank"],
        "url" => ["can't be blank"]
      }} == result
    end

    test "create success", %{conn: conn, gallery_id: gallery_id} do
      params = %{"title" => "My image", "gallery_id" => gallery_id, "url" => "http://teste.com.br"}

      result =
        post(conn, Routes.image_path(conn, :create), params)
        |> json_response(:ok)

      assert %{
               "image" => %{
                 "id" => _,
                 "title" => "My image",
                 "gallery_id" => _
               }
             } = result
    end
  end

  describe "update" do
    setup %{conn: conn, gallery_id: gallery_id} do

      {:ok, %{id: image_id}} = Image.create(%{"title" => "My Image", "gallery_id"=> gallery_id, "url" => "http://teste.com.br"})
      {:ok, conn: conn, image_id: image_id}
    end

    test "update faild", %{conn: conn, image_id: image_id} do
      params = %{"title" => ""}

      result =
        put(conn, Routes.image_path(conn, :update, image_id), params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"title" => ["can't be blank"]}} == result
    end

    test "update success", %{conn: conn, image_id: image_id} do
      params = %{"title" => "My Image2"}

      result =
        put(conn, Routes.image_path(conn, :update, image_id), params)
        |> json_response(:ok)

      assert %{
               "image" => %{
                 "id" => _,
                 "title" => "My Image2"
               }
             } = result
    end
  end

  describe "show" do
    setup %{conn: conn, gallery_id: gallery_id} do
      {:ok, %{id: image_id}} = Image.create(%{"title" => "My Image", "gallery_id"=> gallery_id, "url" => "http://teste.com.br"})
      {:ok, conn: conn, image_id: image_id}
    end

    test "show faild", %{conn: conn} do
      result =
        get(conn, Routes.image_path(conn, :show, Ecto.UUID.generate()))
        |> json_response(:not_found)

      assert %{"errors" => %{"detail" => "Not Found"}} == result
    end

    test "show faild, id invalid", %{conn: conn} do
      result =
        get(conn, Routes.image_path(conn, :show, "id_invalid"))
        |> json_response(400)

      assert %{"errors" => %{"detail" => "Id Invalid"}} == result
    end

    test "show success", %{conn: conn, image_id: image_id} do
      result =
        get(conn, Routes.image_path(conn, :show, image_id))
        |> json_response(:ok)

      assert %{
               "image" => %{
                 "id" => _,
                 "title" => "My Image",
                 "url" => _
               }
             } = result
    end
  end
end
