defmodule Themelook.ThemeController do
  use Themelook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
