defmodule SetGame.GameTest do
  use SetGame.ModelCase, async: true
  alias SetGame.Game
  alias SetGame.Player

  setup do
    {:ok, game} = Game.start_link()

    {:ok, game: game}
  end

  describe "join" do
    test "player numbers and counts are sequential as they join", %{game: game} do
      assert {:ok, 1, [%Player{}]} = Game.join(game)
      assert {:ok, 2, [%Player{}, %Player{}]} = Game.join(game)
      assert {:ok, 3, [%Player{} , %Player{}, %Player{}]} = Game.join(game)
    end
  end

  describe "start" do
    test "initializes the game board", %{game: game} do
      {:ok, board} = Game.start(game)

      assert length(board) == 12
    end
  end
end
