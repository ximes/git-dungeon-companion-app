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
  end

  def register_repo(game, game_repo_name \\ "git-dungeon-playground") do
    %{game | repo_url: game_repo_name}
  end

  def register_team(game, team) do
    # TODO: set team order
    team = %Team{team | dungeon_master: false}

    game
    |> Map.put(:teams, [team | Map.get(game, :teams)])
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
  def update_game_state(game, :finished = new_state), do: update_state_map(game, new_state)
  def update_game_state(game, new_state), do: update_state_map(game, new_state)

  defp update_state_map(game, new_state) do
    case Enum.member?(@allowed_states, new_state) do
      false ->
        raise ArgumentError,
          message: "status must be one of: #{inspect(@allowed_states)}"

      true ->
        Map.put(game, :status, new_state)
    end
  end
end
