defmodule SetGame.BoardTest do
  use SetGame.ModelCase, async: true

  describe "init" do
    test "extracts 12 cards from the deck for the board" do
      deck = SetGame.Deck.init()
      {board, tail} = SetGame.Board.init(deck)

      assert length(board) == 12
      assert length(tail) == 81 - 12
    end
  end
end
