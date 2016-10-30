defmodule Themelook.Application do
  import Plug.Conn
  alias Themelook.{Repo, Category}

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    home_categories = Repo.all(Category)
    assign(conn, :home_categories, home_categories)
  end

end
