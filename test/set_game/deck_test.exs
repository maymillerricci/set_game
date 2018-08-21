defmodule SetGame.DeckTest do
  use SetGame.ModelCase, async: true

  describe "init" do
    test "generated deck is 3^4 unique cards" do
      deck = SetGame.Deck.init()

      assert length(deck) == 3 * 3 * 3 * 3
      assert deck == Enum.uniq(deck)
    end
  end
end
