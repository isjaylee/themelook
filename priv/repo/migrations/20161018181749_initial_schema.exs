defmodule Themelook.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      timestamps
    end

    create table(:themes) do
      add :name,         :string
      add :publisher,    :string
      add :description,  :text
      add :price,        :decimal
      add :theme_link,   :string
      add :demo_link,    :string
      add :image,        :string
      add :added_by,     :string
      timestamps
    end

    create table(:themes_categories) do
      add :theme_id, references(:themes)
      add :category_id, references(:categories)
      timestamps
    end
  end
end
