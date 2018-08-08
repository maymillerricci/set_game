defmodule SetGame.GameTest do
  use SetGame.ModelCase, async: true
  alias SetGame.Game

  setup do
    {:ok, state} = Game.start_link()

    {:ok, state: state}
  end

  describe "join" do
    test "player numbers are sequential as they join", %{state: state} do
      {:ok, 1} = SetGame.Game.join(state)
      {:ok, 2} = SetGame.Game.join(state)
      {:ok, 3} = SetGame.Game.join(state)
    end
  end
end
