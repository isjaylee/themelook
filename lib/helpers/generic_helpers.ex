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

  def form_active_checkbox(conn, id) do
    case Map.has_key?(conn.assigns, :theme) do
      false ->
        nil
      _ ->
        active = conn.assigns.theme.categories |> Enum.map(fn(x) -> x.id end) |> Enum.member?(id)

        case active do
          true ->
            "checked"
          _ ->
            nil
        end

    end
  end
end
