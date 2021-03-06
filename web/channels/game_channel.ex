defmodule SetGame.GameChannel do
  use SetGame.Web, :channel

  intercept(["welcome"])

  def join("game:" <> id, _payload, socket) do
    game =
      case SetGame.Game.Supervisor.new_game(id) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end

    case SetGame.Game.join(game) do
      {:ok, player, players} ->
        socket =
          socket
          |> assign(:game_id, id)
          |> assign(:player, player)
          |> assign(:players, players)

        send(self(), :after_join)
        {:ok, socket}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  def handle_info(:after_join, socket) do
    broadcast(socket, "player_joined", %{players: socket.assigns.players})
    broadcast(socket, "welcome", %{player: socket.assigns.player})

    {:noreply, socket}
  end

  def handle_out("welcome", payload, socket) do
    if payload.player == socket.assigns.player do
      push(socket, "welcome", payload)
    end

    {:noreply, socket}
  end

  def handle_in("start_game", _payload, socket) do
    game = SetGame.Game.Supervisor.find_game(socket.assigns.game_id)
    {:ok, board} = SetGame.Game.start(game)
    broadcast(socket, "game_started", %{board: board})

    {:reply, :ok, socket}
  end
end
