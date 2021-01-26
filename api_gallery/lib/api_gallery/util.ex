defmodule ApiGallery.Util do
  alias Ecto.UUID

  def valid_uuid(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, "Id Invalid"}
      {:ok, id} -> {:ok, id}
    end
  end
end
