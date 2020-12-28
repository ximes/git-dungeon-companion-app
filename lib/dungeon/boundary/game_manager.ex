defmodule Dungeon.Boundary.GameManager do
  alias Dungeon.Core.Game
  use GenServer

  @impl true
  def init(opts \\ %{}) do
    {:ok, Game.new(opts)}
  end

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, %{}, options)
  end

  @impl true
  def handle_call({:setup, :dungeon_master, value}, _from, game),
    do: {:reply, :ok, Game.register_dungeon_master(game, value)}

  def handle_call({:setup, :team, value}, _from, game),
    do: {:reply, :ok, Game.register_team(game, value)}

  def handle_call({:setup, :repo, value}, _from, game),
    do: {:reply, :ok, Game.register_repo(game, value)}

  def handle_call({:stats}, _from, game), do: {:reply, game, game}

  def handle_call({:start}, _from, game), do: handle_state_response(game, Game.start!(game))
  def handle_call({:pause}, _from, game), do: handle_state_response(game, Game.pause!(game))
  def handle_call({:restore}, _from, game), do: handle_state_response(game, Game.restore!(game))
  def handle_call({:end}, _from, game), do: handle_state_response(game, Game.end!(game))

  defp handle_state_response(game, fun) do
    case called = fun do
      {:error, error} -> {:reply, {:error, error}, game}
      _ -> {:reply, :ok, called}
    end
  end

  def add_dungeon_master(manager \\ __MODULE__, value),
    do: GenServer.call(manager, {:setup, :dungeon_master, value})

  def add_team(manager \\ __MODULE__, value), do: GenServer.call(manager, {:setup, :team, value})
  def add_repo(manager \\ __MODULE__, value), do: GenServer.call(manager, {:setup, :repo, value})
  def stats(manager \\ __MODULE__), do: GenServer.call(manager, {:stats})

  def start!(manager \\ __MODULE__), do: GenServer.call(manager, {:start})
  def pause!(manager \\ __MODULE__), do: GenServer.call(manager, {:pause})
  def restore!(manager \\ __MODULE__), do: GenServer.call(manager, {:restore})
  def end!(manager \\ __MODULE__), do: GenServer.call(manager, {:end})
end
