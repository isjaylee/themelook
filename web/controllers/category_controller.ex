defmodule Themelook.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    themes = Repo.all(Theme)
    render(conn, "index.html",
      themes: themes,
      categories: categories
    )

  end

  def show(conn, %{"id" => id}) do
    categories = Repo.all(Category)
    category = Repo.get(Category, id)
    themes = Repo.all(assoc(category, :themes))
    render(conn, "show.html",
      themes: themes,
      categories: categories,
      category: category
    )
  end
end
