defmodule Themelook.Api.V1.CategoryView do
  use Themelook.Web, :view

  def render("index.json", %{categories: categories}) do
    render_many(categories, Themelook.Api.V1.CategoryView, "category.json")
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
    }
  end
end
