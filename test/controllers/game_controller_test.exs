defmodule SetGame.GameControllerTest do
  use SetGame.ConnCase, async: true

  test "new", %{conn: conn} do
    conn = get(conn, game_path(conn, :new))
    assert redirected_to(conn) =~ "/game/"
  end

  test "show", %{conn: conn} do
    conn = get(conn, game_path(conn, :show, Ecto.UUID.generate()))
    assert html_response(conn, 200) =~ "Start Game"
  end
end
