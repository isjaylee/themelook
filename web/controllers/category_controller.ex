defmodule Themelook.CategoryController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Category}

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    render(conn, "show.html", category: category)
  end
end
