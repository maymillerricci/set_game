defmodule SetGame.Deck do
  @colors [:blue, :pink, :yellow]
  @numbers [1, 2, 3]
  @patterns [:empty, :dots, :solid]
  @shapes [:heart, :moon, :star]

  def init do
    for color <- @colors,
        number <- @numbers,
        pattern <- @patterns,
        shape <- @shapes do
      %SetGame.Card{
        color: color,
        number: number,
        pattern: pattern,
        shape: shape
      }
    end
  end
end
