defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category}

  def index(conn, _params) do
    themes = Repo.all(from theme in Theme, limit: 10)
    render(conn, "index.html", themes: themes)
  end

  def show(conn, %{"id" => id}) do
    theme = Repo.get!(Theme, id)
    render(conn, "show.html", theme: theme)
  end

  def search(conn, params) do
    categories = Repo.all(Category)
    themes =
    t in Theme
    |> from(where: fragment("name ilike ?", ^"%#{params["search"]["name"]}%"))
    |> IO.inspect
    |> Repo.all
    |> Repo.preload(:categories)
    render(conn, "search.html", themes: themes, categories: categories)
  end

end
