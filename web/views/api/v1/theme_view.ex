defmodule Themelook.Api.V1.ThemeView do
  use Themelook.Web, :view

  def render("index.json", %{themes: themes}) do
    render_many(themes, Themelook.Api.V1.ThemeView, "theme.json")
  end

  def render("search.json", %{themes: themes}) do
    render_many(themes, Themelook.Api.V1.ThemeView, "theme.json")
  end

  def render("theme.json", %{theme: theme}) do
    %{
      id: theme.id,
      name: theme.name,
      description: theme.description,
      publisher: theme.publisher,
      price: theme.price,
      categories: theme.categories,
      image: theme.image,
      demo_link: theme.demo_link,
      theme_link: theme.theme_link,
    }
  end
end
