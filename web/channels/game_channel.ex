defmodule SetGame.GameChannel do
  use SetGame.Web, :channel

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
    game = SetGame.Game.Supervisor.find_game(socket.assigns.game_id)

    broadcast(socket, "player_joined", %{
      player: socket.assigns.player,
      players: socket.assigns.players
    })

    {:noreply, socket}
  end
end
