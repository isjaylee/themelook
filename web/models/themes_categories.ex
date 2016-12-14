defmodule Themelook.ThemesCategories do
  use Themelook.Web, :model

  schema "themes_categories" do
    field :theme_id, :integer
    field :category_id, :integer
    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:theme_id, :category_id])
    |> validate_required([:theme_id, :category_id])
  end

end
