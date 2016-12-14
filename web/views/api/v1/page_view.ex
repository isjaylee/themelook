defmodule Themelook.Api.V1.PageView do
  use Themelook.Web, :view

  def render("send_submit.json", _params) do
    %{status: "Sent"}
  end

end
