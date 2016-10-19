defmodule Themelook.Api.V1.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Category}

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

end
