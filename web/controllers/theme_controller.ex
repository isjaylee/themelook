defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category, Coherence}
  # Coherence.Authentication.Session, protected: true when action != :index

  def index(conn, _params) do
    themes = Repo.all(from t in Theme, limit: 10)
    render(conn, "index.html", themes: themes)
  end

  def show(conn, %{"id" => id}) do
    theme = Repo.get!(Theme, id)
    render(conn, "show.html", theme: theme)
  end

  def new(conn, _params) do
    changeset = Theme.changeset(%Theme{categories: [%Category{}]})
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"theme" => theme_params}) do
    changeset = %Theme{} |> Theme.changeset(Map.delete(theme_params, "categories"))
    case Repo.insert(changeset) do
      {:ok, theme} ->
        theme
        |> Repo.preload(:categories)
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:categories, Enum.map(theme_params["categories"]["0"]["categories"], fn(x) -> Repo.get(Category, x) end))
        |> Repo.update!
        conn
        |> put_flash(:info, "Created successfully.")
        |> redirect(to: category_path(conn, :index))
      {:error, changeset} ->
        conn
        render(conn, "new.html", changeset: changeset)
    end
  end

  def search(conn, params) do
    categories = Repo.all(Category)
    themes =
    Repo.all(from t in Theme, where: ilike(t.name, ^"%#{params["search"]["name"]}%"))
    |> Repo.preload(:categories)
    render(conn, "search.html", themes: themes, categories: categories)
  end

  def logout(conn, _params) do
    Coherence.SessionController.delete(conn)
    redirect(conn, to: "/")
  end

end
