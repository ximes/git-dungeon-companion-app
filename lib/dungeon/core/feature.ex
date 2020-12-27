defmodule Dungeon.Core.Feature do
  @enforce_keys [:name]

  defstruct name: nil,
            difficulty: ~w[easy medium hard]a,
            description: nil

  # "Maggie should respond to 'sum values' and sum values in array provided as input",
  # "Maggie should respond to 'add values' and sum values in array provided as input",
  # "Maggie should respond to 'sum all json values' and sum values in json provided as input",
  # "Maggie should respond to 'length' and return length of string provided as input", # if conflict, rename both
  # "Maggie should respond to 'length' and return length of array provided as input", # if conflict, rename both
  # "Maggie should respond to 'sum add values' and return sum values in json provided as input, plus the total length of the json input",
  # "Maggie should respond to 'miaow' and return possible responses",
  # "Maggie should respond to 'nej' and return 'nope'",
  # "Maggie should respond to any unexpect value with a list of number a not matching feature was requested",
end
