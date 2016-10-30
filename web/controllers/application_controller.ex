defmodule Themelook.Application do
  import Plug.Conn
  alias Themelook.{Repo, Category}

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    categories = Repo.all(Category)
    assign(conn, :categories, categories)
  end
end