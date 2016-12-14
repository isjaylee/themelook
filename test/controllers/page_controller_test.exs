defmodule Themelook.PageControllerTest do
  use Themelook.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert conn.status == 200
  end
end
