defmodule Themelook.Api.V1.ThemeController do
  use Themelook.Web, :controller
  alias Themelook.{Theme}

  # Coherence.Authentication.Session, protected: true when action != :index

  def index(conn, _params) do
    themes = Repo.all(Theme)
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

end
