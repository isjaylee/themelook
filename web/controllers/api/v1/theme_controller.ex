defmodule Themelook.Api.V1.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Theme, Category}

  plug Coherence.Authentication.Session, [protected: true] when action in [ :create]

  def index(conn, params) do
    offset = if is_nil(params["offset"]), do: 16, else: params["offset"]
    themes = Repo.all(from t in Theme, order_by: [desc: t.inserted_at], limit: 16, offset: ^offset, preload: :categories)
    render(conn, "index.json", themes: themes)
  end

  def create(conn, theme_params) do
    changeset = Theme.changeset(%Theme{}, theme_params)

    case Repo.insert(changeset) do
      {:ok, theme} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", theme_path(conn, :show, theme))
        |> render("show.json", service: theme)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Themelook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def search_themes(conn, params) do
    categories = Repo.all(Category)
    offset = if is_nil(params["offset"]), do: 0, else: params["offset"]
    query = %{from: offset, size: 20, query: %{bool: %{must: [], filter: %{bool: %{must: nil, should: nil, filter: %{range: %{price: %{gte: nil, lte: nil}}}}}}}}
    search_params = []
    if params["search_themes"]["name"] != "", do: search_params = search_params ++ [%{ "match": %{ "name": %{"query": params["search_themes"]["name"], "fuzziness": 2}}}]
    if params["search_themes"]["publisher"] != "", do: search_params = search_params ++ [%{ "match": %{ "publisher": %{"query": params["search_themes"]["publisher"], "fuzziness": 2}}}]
    query = put_in(query, [:query, :bool, :must], search_params)
    if params["search_themes"]["max"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :filter, :range, :price, :lte], params["search_themes"]["max"])
    if params["search_themes"]["min"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :filter, :range, :price, :gte], params["search_themes"]["min"])
    category_ids = Enum.filter(params["categories"], fn({k,v}) -> v == "true" end) |> Enum.into(%{}) |> Map.keys
    if category_ids != [], do: query = put_in(query, [:query, :bool, :filter, :bool, :should], %{terms: %{categories: category_ids}})
    if params["search_themes"]["framework_id"] != "", do: query = put_in(query, [:query, :bool, :filter, :bool, :must], %{terms: %{categories: [params["search_themes"]["framework_id"]]}})

    {:ok, code, response} = post("/themelook/themes/_search", [], Poison.encode!(query))

    theme_ids = response.hits.hits |> Enum.map(& &1[:_id])
    themes = Repo.all(from t in Theme, where: t.id in ^theme_ids, preload: :categories)
    render(conn, "search.json", themes: themes, categories: categories, disable_sidebar: true)
  end
end
