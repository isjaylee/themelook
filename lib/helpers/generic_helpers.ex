defmodule Themelook.GenericHelpers do
  require IEx

  def active_checkbox(conn, id) do
    if conn.params["categories"] != nil do
      active =
        conn.params["categories"]
        |> Map.fetch!(Integer.to_string(id))

      case active do
        "true" ->
          "checked"
        _ ->
          nil
      end
    end
  end

end
