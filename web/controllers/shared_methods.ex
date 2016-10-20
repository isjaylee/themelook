defmodule Themelook.SharedMethods do
  import Plug.Conn
  alias Themelook.{Repo, Category}

  def init(options) do
    options
  end

  def call(conn, _opts) do
    categories = Repo.all(Category)
    assign(conn, :categories, categories)
  end
end
