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

Themelook.Repo.delete_all Themelook.User

Themelook.User.changeset(%Themelook.User{}, %{name: "Admin", email: "admin@example.com", password: "password", password_confirmation: "password"})
|> Themelook.Repo.insert!
