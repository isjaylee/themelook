defmodule Themelook.Theme do
  use Themelook.Web, :model
  alias Themelook.{Category, ThemesCategories}
  @derive {Poison.Encoder, only: [:id, :name, :publisher, :description, :price, 
                                  :updated_at, :inserted_at, :categories, :image, :demo_link, 
                                  :theme_link]}

  schema "themes" do
    field :name, :string
    field :publisher, :string
    field :description, :string
    field :image, :string
    field :theme_link, :string
    field :demo_link, :string
    field :price, :integer
    many_to_many :categories, Category, join_through: ThemesCategories 

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :publisher, :description, :price, :image])
    |> validate_required([:name, :publisher])
  end

end
