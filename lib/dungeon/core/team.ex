defmodule Dungeon.Core.Team do
  @enforce_keys [:name]

  defstruct name: nil,
            github_handle: nil,
            active: false,
            dungeon_master: false,
            order: 0,
            # TODO: [%Perk]
            used_perks: [],
            # TODO: [%Perk]
            active_perks: [],
            # TODO: [%Perk]
            review_perks: [],
            # TODO: [%Perk]
            active_review_perks: [],
            # TODO: [%Feature]
            completed_features: [],
            # TODO: %Feature
            active_feature: nil

  # TODO for matching boundary/controller:
  # login on github
end
