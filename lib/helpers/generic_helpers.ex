defmodule Themelook.GenericHelpers do
  require IEx

  def show_sidebar(conn) do
    paths = ["/about", "/themes", "/themes/new"]
    Enum.any?(paths, fn(path) ->
      conn.request_path == path
    end)
  end
end
