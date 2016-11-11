defmodule Themelook.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Repo, Theme, Category}
  plug Coherence.Authentication.Session, [protected: true] when not action in [:show, :search_themes]
  plug :disable_sidebar when action in [:index, :new, :edit]

  def index(conn, _params) do
    themes = Repo.all(from t in Theme, order_by: [desc: t.id]) |> Repo.preload(:categories)
    render(conn, "index.html", themes: themes, disable_search_form: true, disable_sidebar: true)
  end

  def show(conn, %{"id" => id}) do
    theme = Repo.get!(Theme, id) |> Repo.preload(:categories)
    categories = Repo.all(Category)
    render(conn, "show.html", theme: theme, categories: categories)
  end

  def new(conn, _params) do
    changeset = Theme.changeset(%Theme{categories: [%Category{}]})
    categories = Repo.all(from c in Category, order_by: [asc: c.name])
    render(conn, "new.html", changeset: changeset, conn: conn, categories: categories, disable_search_form: true)
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
        |> Ecto.Changeset.put_assoc(:categories, Enum.filter(conn.params["categories"], fn({k,v}) -> v == "true" end) |> Enum.map(fn({k,v}) -> Repo.get(Category, k) end))
        |> Repo.update!

        theme_with_cats = theme |> Repo.preload(:categories)
        category_ids = Enum.reduce(theme_with_cats.categories, [], fn(x,acc) -> acc ++ [x.id] end)
        put("/themelook/themes/#{theme.id}", [name: theme.name, price: theme.price,
                                              description: theme.description, publisher: theme.publisher,
                                              categories: category_ids])
        conn
        |> put_flash(:info, "Created successfully.")
        |> redirect(to: category_path(conn, :index))
      {:error, changeset} ->
        conn
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    theme = Repo.get(Theme, id) |> Repo.preload(:categories)
    categories = Repo.all(from c in Category, order_by: [asc: c.name])
    changeset = theme |> Theme.changeset
    render(conn, "edit.html", changeset: changeset, theme: theme, conn: conn, categories: categories, disable_search_form: true)
  end

  def update(conn, %{"id" => id, "theme" => theme_params}) do
    if theme_params["image"] != nil do
      {:ok, url} = ExCloudinary.upload_image(theme_params["image"].path)
      theme_params = Map.put(theme_params, "image", url.url)
    end
    theme = Repo.get!(Theme, id) |> Repo.preload(:categories)
    changeset = theme |> Theme.changeset(Map.drop(theme_params, ["categories"]))

    case Repo.update(changeset) do
      {:ok, theme} ->
        theme
        |> Repo.preload(:categories)
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:categories, Enum.filter(conn.params["categories"], fn({k,v}) -> v == "true" end) |> Enum.map(fn({k,v}) -> Repo.get(Category, k) end))
        |> Repo.update!

        category_ids =
          Enum.filter(conn.params["categories"], fn({k,v}) -> v == "true" end)
          |> Enum.into(%{})
          |> Map.keys
          |> Enum.reduce([], fn(x, acc) -> acc ++ [String.to_integer(x)] end)

        put("/themelook/themes/#{theme.id}", [name: theme.name, price: theme.price,
                                              description: theme.description, publisher: theme.publisher,
                                              categories: category_ids])
        conn
        |> put_flash(:info, "Theme updated successfully.")
        |> redirect(to: theme_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", theme: theme, changeset: changeset)
    end
  end

  def search_themes(conn, params) do
    categories = Repo.all(Category)
    query = %{from: 0, size: 20, query: %{bool: %{must: [], filter: %{bool: %{must: nil, should: nil, filter: %{range: %{"price.coef": %{gte: nil, lte: nil}}}}}}}}
    search_params = []
    if params["search_themes"]["name"] != "", do: search_params = search_params ++ [%{ "match": %{ "name": %{"query": params["search_themes"]["name"], "fuzziness": 2}}}]
    if params["search_themes"]["publisher"] != "", do: search_params = search_params ++ [%{ "match": %{ "publisher": %{"query": params["search_themes"]["publisher"], "fuzziness": 2}}}]
    query = put_in(query, [:query, :bool, :must], search_params)
    if params["search_themes"]["max"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :filter, :range, :"price.coef", :lte], params["search_themes"]["max"])
    if params["search_themes"]["min"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :filter, :range, :"price.coef", :gte], params["search_themes"]["min"])
    category_ids = Enum.filter(params["categories"], fn({k,v}) -> v == "true" end) |> Enum.into(%{}) |> Map.keys
    if category_ids != [], do: query = put_in(query, [:query, :bool, :filter, :bool, :should], %{terms: %{categories: category_ids}})
    if params["search_themes"]["framework_id"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :must], %{terms: %{categories: [params["search_themes"]["framework_id"]]}})

    {:ok, code, response} = post("/themelook/themes/_search", [], Poison.encode!(query))

    theme_ids = response.hits.hits |> Enum.map(& &1[:_id])
    themes = Repo.all(from t in Theme, where: t.id in ^theme_ids, preload: :categories)
    render(conn, "search.html", themes: themes, categories: categories, search_params: params, disable_sidebar: true)
  end

  def logout(conn, _params) do
    Coherence.SessionController.delete(conn)
    redirect(conn, to: "/")
  end

  defp disable_sidebar(conn, _params) do
    assign(conn, :disable_sidebar, true)
  end

end
