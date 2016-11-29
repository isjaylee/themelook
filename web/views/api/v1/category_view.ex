defmodule Themelook.Api.V1.CategoryView do
  use Themelook.Web, :view

  def render("index.json", %{categories: categories}) do
    render_many(categories, Themelook.Api.V1.CategoryView, "category.json")
  end

  def render("show.json", %{themes: themes}) do
    render_many(themes, Themelook.Api.V1.ThemeView, "theme.json")
  end

end
