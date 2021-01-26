defmodule ApiGalleryUpload.ClientQueueTest do
  use ExUnit.Case, async: true
  alias ApiGalleryUpload.ClientQueue

  describe "send/4" do
    test "bucket-success" do
      assert :ok == ClientQueue.send(:test, "", "", %{})
      assert :ok == ClientQueue.send(:test, "", "", "mensagem")
    end
  end
end
