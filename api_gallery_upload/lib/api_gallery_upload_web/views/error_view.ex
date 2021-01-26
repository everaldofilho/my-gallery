defmodule ApiGalleryUploadWeb.ErrorView do
  use ApiGalleryUploadWeb, :view

  import Ecto.Changeset

  def render("400.json", %{result: %{"errors"=> errors}}), do: %{errors: errors}
  def render("400.json", %{result: result}), do: %{errors: %{detail: result}}

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
