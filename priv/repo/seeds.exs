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

alias Themelook.{Repo, User, Category}

Repo.delete_all(User)

User.changeset(%User{}, %{name: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password"})
|> Repo.insert!

for category <- ["Restaurant", "Home Improvement", "Health & Beauty", "Blog", "Business", "Fashion", "Photography"] do
    Repo.insert!(%Category{name: category})
end
