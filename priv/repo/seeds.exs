# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Themelook.Repo.insert!(%Themelook.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Tirexs.HTTP

alias Themelook.{Repo, User, Category, Theme}

Repo.delete_all(User)

User.changeset(%User{}, %{name: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password", role: "Admin"})
|> Repo.insert!

User.changeset(%User{}, %{name: "Bob", email: "bob@example.com", password: "password", password_confirmation: "password"})
|> Repo.insert!

for category <- ["Restaurant", "Home Improvement", "Health & Beauty", "Blog", "Business", "Fashion", "Photography", "Multipurpose", "News & Magazine",
"Travel & Hotels", "Wedding", "Real Estate", "Nonprofit", "Admin", "Wordpress", "Shopify", "HTML", "Opencart", "Prestashop"] do
  Repo.insert!(%Category{name: category})
end


Repo.insert!(%Theme{name: "Divi", publisher: "Elegant Themes", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", price: 69, demo_link: "https://www.google.com", theme_link: "http://espn.com"})
|> Repo.preload(:categories)
|> Ecto.Changeset.change()
|> Ecto.Changeset.put_assoc(:categories, [Repo.get(Category, 1), Repo.get(Category, 2)])
|> Repo.update!


Repo.insert!(%Theme{name: "Genesis", publisher: "Studio Press", description: "Vivamus ullamcorper eu ipsum fringilla viverra.", price: 169, demo_link: "http://cnn.com", theme_link: "https://facebook.com"})
|> Repo.preload(:categories)
|> Ecto.Changeset.change()
|> Ecto.Changeset.put_assoc(:categories, [Repo.get(Category, 4), Repo.get(Category, 5)])
|> Repo.update!

Repo.insert!(%Theme{name: "Thesis", publisher: "DIYthemes", description: "Pellentesque aliquet lorem neque, quis ullamcorper leo gravida quis.", price: 139})
Repo.insert!(%Theme{name: "Avada", publisher: "Theme Fusion", description: "Nam gravida ex a quam placerat, ut vehicula magna ornare.", price: 59})
Repo.insert!(%Theme{name: "Gantry", publisher: "RocketTheme", description: "Gantry makes use of widgetized page layouts, where individual widgets can be dragged and dropped into place to populate the page layouts with content.", price: 0})


# Index themes in Elasticsearch
themes = Repo.all(Theme)

Enum.each(themes, fn(x) ->
  theme = x |> Repo.preload(:categories)
  category_ids = Enum.reduce(theme.categories, [], fn(x,acc) -> acc ++ [x.id] end)
  put("/themelook/themes/#{theme.id}", [name: theme.name, price: Decimal.to_string(theme.price) |> Float.parse |> elem(0), description: theme.description, publisher: theme.publisher, categories: category_ids])
end)
