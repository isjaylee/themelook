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
      add :description,  :string
      add :price,        :integer
      add :link,         :string
      add :image,        :string
      timestamps
    end

    create table(:themes_categories) do
      add :theme_id, references(:themes)
      add :category_id, references(:categories)
      timestamps
    end

    create table(:reviews) do
      add :comment,      :string
      add :rating,       :integer

      add :theme_id, references(:themes)
      add :user_id,  references(:users)
      timestamps
    end


    create index(:reviews, [:theme_id])
    create index(:reviews, [:user_id])
  end
end
