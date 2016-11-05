defmodule Themelook.PageController do
  use Themelook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html", disable_sidebar: true, disable_search_form: true
  end

  def terms(conn, _params) do
    render conn, "terms.html", disable_sidebar: true, disable_search_form: true
  end

  def privacy(conn, _params) do
    render conn, "privacy.html", disable_sidebar: true, disable_search_form: true
  end
end
