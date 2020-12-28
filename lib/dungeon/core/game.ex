defmodule Dungeon.Core.Game do
  alias Dungeon.Core.Team
  @allowed_states ~w[new setup ready started paused finished]a

  defstruct repo_url: nil,
            dungeon_master: nil,
            teams: [],
            status: :new,
            # TODO: [%Event]
            events_fulfilled: [],
            # TODO: [%Perk]
            used_perks: [],
            used_review_perks: [],
            completed_features: [],
            current_day: 0

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def register_dungeon_master(game, team) do
    dungeon_master = %Team{team | dungeon_master: true}

    %{game | dungeon_master: dungeon_master}
    |> update_to_state_or_setup(:ready)
  end

  def register_repo(game, game_repo_name \\ "git-dungeon-playground") do
    %{game | repo_url: game_repo_name}
    |> update_to_state_or_setup(:ready)
  end

  def register_team(game, team) do
    # TODO: set team order
    team = %Team{team | dungeon_master: false}

    Map.put(game, :teams, [team | Map.get(game, :teams)])
    |> update_to_state_or_setup(:ready)
  end

  def ready?(game) do
    cond do
      game.repo_url == nil -> {:error, "No repo url set up"}
      game.dungeon_master == nil -> {:error, "No account for Dungeon Master set up"}
      length(game.teams) <= 1 -> {:error, "No Player Team set up"}
      true -> {:ok}
    end
  end

  # TODO: do something amazing with state transitions
  def start!(game) do
    ready_check = ready?(game)

    case ready_check do
      {:ok} ->
        game
        |> update_state_map(:started)
        |> notify_clients

      {:error, _} ->
        update_state_map(game, :setup)
        ready_check
    end
  end

  def pause!(game), do: update_state_map(game, :paused)
  def restore!(game), do: update_state_map(game, :started)
  def end!(game), do: update_state_map(game, :finished)

  defp update_to_state_or_setup(game, state) do
    case ready?(game) do
      {:ok} -> update_state_map(game, state)
      {:error, _} -> update_state_map(game, :setup)
    end
  end

  defp update_state_map(game, new_state) do
    case Enum.member?(@allowed_states, new_state) do
      false ->
        raise ArgumentError,
          message: "status must be one of: #{inspect(@allowed_states)}"

      true ->
        Map.put(game, :status, new_state)
    end
  end

  defp notify_clients(game) do
    # TODO:
    game
  end
end
