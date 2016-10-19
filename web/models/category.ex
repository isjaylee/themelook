defmodule Themelook.Category do
  use Themelook.Web, :model
  alias Themelook.{Theme, ThemesCategories}
  @derive {Poison.Encoder, only: [:id, :name]}

  schema "categories" do
    field :name, :string
    many_to_many :themes, Theme, join_through: ThemesCategories

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end
