defmodule Day14Test do
  use ExUnit.Case
  import Advent.Day14
  alias Advent.Day14.Polymer

  def example_data do
    data = "NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C"

    data
    |> String.split("\n")
    |> Polymer.parse_polymer_data()
  end

  test "part 1" do
    polymer = example_data()

    occurrences =
      polymer
      |> Polymer.step_times(10)
      |> Map.get(:occurrences)
      |> Map.values()

    result = Enum.max(occurrences) - Enum.min(occurrences)
    assert result == 1588
  end
end
