defmodule ApiGalleryUpload.ClientAwsTest do
  use ExUnit.Case, async: true
  alias ApiGalleryUpload.ClientAws

  describe "send_bucket/1" do
    test "bucket-success" do
      image = %{filename: "test_helper.jpeg", path: "/app/test/test_helper.exs"}
      assert {:ok, url} = ClientAws.send_bucket(image)
    end
  end
end
