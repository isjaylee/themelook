defmodule Themelook.Theme do
  use Themelook.Web, :model
  alias Themelook.{Category, ThemesCategories}
  @derive {Poison.Encoder, only: [:id, :name, :publisher, :description, :price, :updated_at, :inserted_at]}

  schema "themes" do
    field :name, :string
    field :publisher, :string
    field :description, :string
    field :price, :integer
    many_to_many :categories, Category, join_through: ThemesCategories 

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end
