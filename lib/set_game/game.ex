defmodule SetGame.Game do
  use GenServer

  def join(game) do
    GenServer.call(game, :join)
  end

  def start(game) do
    GenServer.call(game, {:start})
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
    players = [player] ++ state.players

    {:reply, {:ok, player_number, players}, %{state | players: players}}
  end

  def handle_call({:start}, _from, state) do
    {:reply, {:ok}, %{state | status: :in_progress}}
  end
end
