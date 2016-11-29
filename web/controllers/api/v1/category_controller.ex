defmodule Themelook.Api.V1.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get(Category, id)
    themes = Repo.all(from t in assoc(category, :themes), preload: :categories, limit: 16, offset: ^conn.params["offset"])
    render(conn, "show.json",
      themes: themes,
      category: category
    )
  end

end
