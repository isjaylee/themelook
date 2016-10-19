defmodule Themelook.Theme do
  use Themelook.Web, :model
  @derive {Poison.Encoder, only: [:id, :name]}

  schema "themes" do
    field :name, :string
    field :publisher, :string
    field :description, :string
    field :price, :integer

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end
