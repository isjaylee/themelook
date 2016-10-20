defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme}

  def index(conn, _params) do
    themes = Repo.all(Theme)
    render(conn, "index.html", themes: themes)
  end

  def show(conn, %{"id" => id}) do
    theme = Repo.get!(Theme, id)
    render(conn, "show.html", theme: theme)
  end
end
