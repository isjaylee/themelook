defmodule ContactForm do
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "" do
    field :from,    :string, virtual: true
    field :subject, :string, virtual: true
    field :body,    :binary, virtual: true
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:from, :subject, :body])
  end
end
