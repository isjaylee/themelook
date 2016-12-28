defmodule Themelook.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    themes = Repo.all(from t in Theme, order_by: [desc: t.inserted_at], preload: :categories, limit: 20)
    render(conn, "index.html",
      themes: themes,
      categories: categories,
      theme_count: length(Repo.all(Theme))
    )

  end

  def show(conn, %{"id" => id}) do
    categories = Repo.all(Category)
    category = Repo.get(Category, id)
    themes = Repo.all(from t in assoc(category, :themes), order_by: [desc: t.inserted_at], preload: :categories, limit: 20)
    render(conn, "show.html",
      themes: themes,
      categories: categories,
      category: category
    )
  end
end
