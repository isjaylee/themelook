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

alias Themelook.{Repo, User, Category, Theme}

Repo.delete_all(User)

User.changeset(%User{}, %{name: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password"})
|> Repo.insert!

for category <- ["Restaurant", "Home Improvement", "Health & Beauty", "Blog", "Business", "Fashion", "Photography"] do
    Repo.insert!(%Category{name: category})
end


Repo.insert!(%Theme{name: "Divi", publisher: "Elegant Themes", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", price: 69})
Repo.insert!(%Theme{name: "Genesis", publisher: "Studio Press", description: "Vivamus ullamcorper eu ipsum fringilla viverra.", price: 169})
Repo.insert!(%Theme{name: "Thesis", publisher: "DIY Themes", description: "Pellentesque aliquet lorem neque, quis ullamcorper leo gravida quis.", price: 139})
Repo.insert!(%Theme{name: "Avada", publisher: "Theme Fusion", description: "Nam gravida ex a quam placerat, ut vehicula magna ornare.", price: 59})
Repo.insert!(%Theme{name: "Gantry", publisher: "RocketTheme", description: "Gantry makes use of widgetized page layouts, where individual widgets can be dragged and dropped into place to populate the page layouts with content.", price: 0})
