defmodule ApiGalleryUploadWeb.UploadControllerTest do
  use ApiGalleryUploadWeb.ConnCase
  import Tesla.Mock

  describe "create" do
    test "error", %{conn: conn} do
      mock(fn %{
                method: :post
              } ->
        %Tesla.Env{
          status: 400,
          body: "bad request"
        }
      end)

      result =
        post(conn, Routes.upload_path(conn, :create), %{
          "gallery_id" => "123123123",
          "image" => %Plug.Upload{
            content_type: "image/jpeg",
            filename: "1528_27.jpg",
            path: "/app/README.md"
          }
        })
        |> json_response(:bad_request)

      assert %{"errors" => %{"detail" => "bad request"}} == result
    end
    test "error, changeset", %{conn: conn} do
      mock(fn %{
                method: :post
              } ->
        %Tesla.Env{
          status: 400,
          body: %{
            "errors" => %{"gallery_id" => ["in blank"]}
          }
        }
      end)

      result =
        post(conn, Routes.upload_path(conn, :create), %{
          "gallery_id" => "123123123",
          "image" => %Plug.Upload{
            content_type: "image/jpeg",
            filename: "1528_27.jpg",
            path: "/app/README.md"
          }
        })
        |> json_response(:bad_request)

      assert %{"errors" => %{"gallery_id" => ["in blank"]}} == result
    end
    test "success", %{conn: conn} do
      image = %{
        "id" => "123456",
        "url" => "http://teste.com.br/teste.jpg",
        "title" => "title"
      }
      mock(fn %{
                method: :post
              } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "image" => image
          }
        }
      end)

      result =
        post(conn, Routes.upload_path(conn, :create), %{
          "gallery_id" => "123123123",
          "image" => %Plug.Upload{
            content_type: "image/jpeg",
            filename: "1528_27.jpg",
            path: "/app/README.md"
          }
        })
        |> json_response(:ok)

      assert %{"data" => image} == result
    end
  end
end
