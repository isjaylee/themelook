defmodule Themelook.User do
  use Themelook.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :role, :string
    coherence_schema

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email, :role] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end
end
