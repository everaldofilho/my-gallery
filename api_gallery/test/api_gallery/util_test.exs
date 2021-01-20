defmodule ApiGallery.UtilTest do
  use ExUnit.Case, async: true
  alias ApiGallery.Util
  alias Ecto.UUID
  describe "valid_uuid/1" do
    test "uuid valid" do
      assert {:ok, _id} = Util.valid_uuid(UUID.generate())
    end

    test "uuid invalid" do
      assert {:error, "Id Invalid"} = Util.valid_uuid("12313asd3a2sd13")
    end
  end

end
