defmodule SetGame.Game.Supervisor do
  def start_link do
    IO.inspect("supervisor: start link")

    import Supervisor.Spec

    children = [
      worker(SetGame.Game, [])
    ]

    opts = [strategy: :simple_one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

  def new_game(id) do
    IO.inspect("supervisor: new game")

    Supervisor.start_child(__MODULE__, [[name: find_game(id)]])
  end

  def find_game(id) do
    IO.inspect("supervisor: find game")

    {:via, Registry, {SetGame.Game.Registry, id}}
  end
end
