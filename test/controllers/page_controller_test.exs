defmodule SetGame.PageControllerTest do
  use SetGame.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "New Game"
  end
end
