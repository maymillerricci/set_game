defmodule SetGame.Board do
  @size 12
  def init(deck) do
    Enum.split(deck, @size)
  end
end
