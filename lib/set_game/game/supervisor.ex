defmodule SetGame.Game.Supervisor do
  def start_link do
    import Supervisor.Spec

    children = [
      worker(SetGame.Game, [])
    ]

    opts = [strategy: :simple_one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

  def new_game(id) do
    Supervisor.start_child(__MODULE__, [[name: find_game(id)]])
  end

  def find_game(id) do
    {:via, Registry, {SetGame.Game.Registry, id}}
  end
end
