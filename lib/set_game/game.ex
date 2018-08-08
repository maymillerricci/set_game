defmodule SetGame.Game do
  use GenServer

  def join(game) do
    GenServer.call(game, :join)
  end

  ###
  # GenServer API
  ###

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_) do
    state = %SetGame.State{status: :waiting_for_players}

    {:ok, state}
  end

  def handle_call(:join, _from, state) do
    player_number = length(state.players) + 1
    player = %SetGame.Player{number: player_number}

    {:reply, {:ok, player_number}, %{state | players: [player] ++ state.players}}
  end
end

