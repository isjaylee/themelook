defmodule Themelook.Theme do
  use Themelook.Web, :model
  alias Themelook.{Category, ThemesCategories}
  @derive {Poison.Encoder, only: [:id, :name, :publisher, :description, :price,
                                  :updated_at, :inserted_at, :categories, :image, :demo_link,
                                  :theme_link, :added_by]}

  schema "themes" do
    field :name,         :string
    field :publisher,    :string
    field :description,  :string
    field :image,        :string
    field :theme_link,   :string
    field :demo_link,    :string
    field :added_by,     :string
    field :price,        :decimal
    many_to_many :categories, Category, join_through: ThemesCategories, on_replace: :delete

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :publisher, :description, :price, :image, :demo_link, :theme_link, :added_by])
    |> validate_required([:name, :publisher])
  end

end
