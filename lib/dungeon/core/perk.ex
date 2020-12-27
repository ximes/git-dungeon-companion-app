defmodule Dungeon.Core.Perk do
  @enforce_keys [:name, :type]

  defstruct name: nil,
            type: ~w[review team]a,
            description: nil

  # Review perks
  # "We dont' accept methods containing the letter a",
  # "Methods should not be longer than 3 lines",
  # "Method names should be in alphabetical order",
  # "No empty lines",
  # "For letters for variable names, please.",
  # "Leave a trailing space after each line with more than 40 characters",
  # "Comments are for pussies.",
  # "Please, leave at least 2 lines of comments before each method",
  # "Could you please rename all snake case variables and method names to pascal case and all pascal case to snake case?",
  # "No variables. Only Constants",
  # "Single quotes, not double quotes",
  # "No preferences, all good",
  # "No preferences, all good",
  # "No preferences, all good",
  # "Could you suffix all variables with a sequential integer please?",
  # "Really, I think we should add a print line here.",
  # "Please, make a single commit."

  # Team Perks
  # "We only use variables named after cats",
  # "No perks, no downs",
  # "Our team is the best!!! We can ignore review comments.",
  # "We should be adding at least 2 lines of comments before each method",
  # "Our tests have only Chtulhu themed dummy data",
  # "At least one methods should be exactly nine lines long",
  # "One. Commit. Per. File."
end
