defmodule ApiGalleryWeb.GalleryControllerTest do
  use ApiGalleryWeb.ConnCase
  alias ApiGallery.Service.Gallery

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "index" do
    test "not data, ok 200", %{conn: conn} do
      result =
        get(conn, Routes.gallery_path(conn, :index))
        |> json_response(:ok)

      assert result == %{"data" => []}
    end

    test "One register, ok 200", %{conn: conn} do
      Gallery.create(%{"name" => "teste"})

      result =
        get(conn, Routes.gallery_path(conn, :index))
        |> json_response(:ok)

      assert %{
               "data" => [
                 %{
                   "id" => _,
                   "images" => [],
                   "inserted_at" => _,
                   "name" => "teste",
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
        post(conn, Routes.gallery_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"name" => ["can't be blank"]}} == result
    end

    test "create success", %{conn: conn} do
      params = %{"name" => "My Gallery"}

      result =
        post(conn, Routes.gallery_path(conn, :create), params)
        |> json_response(:created)

      assert %{
               "gallery" => %{
                 "id" => _,
                 "name" => "My Gallery"
               }
             } = result
    end
  end

  describe "update" do
    setup %{conn: conn} do
      {:ok, %{id: gallery_id}} = Gallery.create(%{"name" => "My Gallery"})
      {:ok, conn: conn, gallery_id: gallery_id}
    end

    test "update faild", %{conn: conn, gallery_id: gallery_id} do
      params = %{"name" => ""}

      result =
        put(conn, Routes.gallery_path(conn, :update, gallery_id), params)
        |> json_response(:bad_request)

      assert %{"errors" => %{"name" => ["can't be blank"]}} == result
    end

    test "update success", %{conn: conn, gallery_id: gallery_id} do
      params = %{"name" => "My Gallery2"}

      result =
        put(conn, Routes.gallery_path(conn, :update, gallery_id), params)
        |> json_response(:ok)

      assert %{
               "gallery" => %{
                 "id" => _,
                 "name" => "My Gallery2"
               }
             } = result
    end
  end

  describe "show" do
    setup %{conn: conn} do
      {:ok, %{id: gallery_id}} = Gallery.create(%{"name" => "My Gallery"})
      {:ok, conn: conn, gallery_id: gallery_id}
    end

    test "show faild", %{conn: conn} do
      result =
        get(conn, Routes.gallery_path(conn, :show, Ecto.UUID.generate()))
        |> json_response(:not_found)

      assert %{"errors" => %{"detail" => "Not Found"}} == result
    end

    test "show success", %{conn: conn, gallery_id: gallery_id} do
      result =
        get(conn, Routes.gallery_path(conn, :show, gallery_id))
        |> json_response(:ok)

      assert %{
               "gallery" => %{
                 "id" => _,
                 "name" => "My Gallery"
               }
             } = result
    end
  end
end
