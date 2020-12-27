defmodule Dungeon.Core.Event do
  @enforce_keys [:name]

  defstruct name: nil,
            when_type: ~w[at_time branches_open opened_pr merged_pr]a,
            when_threshold: nil,
            when_description: nil

  # after_3_merged_pr: :cancel_feature_of_latest_opened_pr,
  # after_5_opened_pr: :swap_features_and_teams, # if not the same team
  # if_more_than_6_branches_open: :force_a_master_and_request_a_pull
end
