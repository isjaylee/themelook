defmodule Themelook.ThemeTest do
  use Themelook.ModelCase
  alias Themelook.{Theme}

  @valid_attrs %{
    name: "Theme1", publisher: "Publisher1", description: "Descr1", image: "http://cloudinary.com",
    theme_link: "http://example.com", demo_link: "http://example.com", added_by: "joe@example.com", price: "88"
   }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Theme.changeset(%Theme{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Theme.changeset(%Theme{}, @invalid_attrs)
    refute changeset.valid?
  end
end
