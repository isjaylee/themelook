defmodule Themelook.Api.V1.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

  def show(conn, params) do
    category = Repo.get(Category, params["id"])
    offset = if is_nil(params["offset"]), do: 0, else: params["offset"]
    themes = get_themes_by_order(params["sort"], category, params["count"], offset)
    render(conn, "show.json", themes: themes, category: category)
  end

  def get_themes_by_order(order, category, count, offset) do
    case order do
      "Price - Low to High" -> Repo.all(from t in assoc(category, :themes), order_by: [asc: t.price],        preload: :categories, limit: ^count, offset: ^offset)
      "Price - High to Low" -> Repo.all(from t in assoc(category, :themes), order_by: [desc: t.price],       preload: :categories, limit: ^count, offset: ^offset)
      "Oldest"              -> Repo.all(from t in assoc(category, :themes), order_by: [asc: t.inserted_at],  preload: :categories, limit: ^count, offset: ^offset)
      _                     -> Repo.all(from t in assoc(category, :themes), order_by: [desc: t.inserted_at], preload: :categories, limit: ^count, offset: ^offset)
    end
  end
end
