defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category}
  plug Coherence.Authentication.Session, [protected: true] when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    themes = Repo.all(from t in Theme, limit: 10) |> Repo.preload(:categories)
    render(conn, "index.html", themes: themes)
  end

  def show(conn, %{"id" => id}) do
    theme = Repo.get!(Theme, id) |> Repo.preload(:categories)
    categories = Repo.all(Category)
    render(conn, "show.html", theme: theme, categories: categories)
  end

  def new(conn, _params) do
    changeset = Theme.changeset(%Theme{categories: [%Category{}]})
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"theme" => theme_params}) do
    if theme_params["image"] != nil do
      {:ok, url} = ExCloudinary.upload_image(theme_params["image"].path)
      theme_params = Map.put(theme_params, "image", url.url)
    end
    changeset = %Theme{} |> Theme.changeset(Map.drop(theme_params, ["categories"]))
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

  def edit(conn, %{"id" => id}) do
    theme = Repo.get(Theme, id) |> Repo.preload([:categories])
    categories = Repo.all(Category) |> Enum.map(&{&1.name, &1.id})
    changeset = theme |> Theme.changeset
    render(conn, "edit.html", changeset: changeset, theme: theme, categories: categories)
  end

  def update(conn, %{"id" => id, "theme" => theme_params}) do
    theme = Repo.get!(Theme, id)
    changeset = Theme.changeset(theme, theme_params)

    case Repo.update(changeset) do
      {:ok, theme} ->
        conn
        |> put_flash(:info, "Theme updated successfully.")
        |> redirect(to: theme_path(conn, :show, theme))
      {:error, changeset} ->
        render(conn, "edit.html", theme: theme, changeset: changeset)
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
