defmodule SetGame.GameController do
  use SetGame.Web, :controller

  def new(conn, _params) do
    game_id = Ecto.UUID.generate()
    redirect conn, to: game_path(conn, :show, game_id)
  end

  def show(conn, _params) do
    render(conn, :show)
  end
end
