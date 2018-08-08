defmodule SetGame.DeckTest do
  use SetGame.ModelCase, async: true

  describe "generate" do
    test "generated deck is 3^4 unique cards" do
      deck = SetGame.Deck.generate()

      assert length(deck) == 3 * 3 * 3 * 3
      assert deck == Enum.uniq(deck)
    end
  end
end
