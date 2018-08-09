defmodule SetGame.Game do
  use GenServer

  def join(game) do
    IO.inspect("game: join")
    GenServer.call(game, :join)
  end

  ###
  # GenServer API
  ###

  def start_link(opts \\ []) do
    IO.inspect("game: start link")
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_) do
    IO.inspect("game: init")
    state = %SetGame.State{status: :waiting_for_players}

    {:ok, state}
  end

  def handle_call(:join, _from, state) do
    IO.inspect("game: handle join call")
    player_number = length(state.players) + 1
    player = %SetGame.Player{number: player_number}

    {:reply, {:ok, player_number}, %{state | players: [player] ++ state.players}}
  end
end
