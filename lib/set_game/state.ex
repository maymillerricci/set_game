defmodule SetGame.State do
  defstruct [
    :current_player,
    :status,
    board: [],
    deck: [],
    players: []
  ]
end
