defmodule Themelook.CategoryTest do
  use Themelook.ModelCase
  alias Themelook.{Category}

  @valid_attrs %{name: "Category1"}

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
