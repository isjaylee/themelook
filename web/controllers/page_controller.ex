defmodule Themelook.PageController do
  use Themelook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html", disable_sidebar: true
  end
end
