defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category, Coherence}
  # Coherence.Authentication.Session, protected: true when action != :index

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
    Repo.all(from t in Theme, where: ilike(t.name, ^"%#{params["search"]["name"]}%"))
    |> Repo.preload(:categories)
    render(conn, "search.html", themes: themes, categories: categories)
  end

  def logout(conn, _params) do
    Coherence.SessionController.delete(conn)
    redirect(conn, to: "/")
  end

end
