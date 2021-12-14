defmodule Advent.Day14 do
  alias Advent.Helpers
  alias Advent.Day14.Polymer

  def part1 do
    data = Helpers.read_lines("data/day_14.txt")
    polymer = Polymer.parse_polymer_data(data)

    occurrences =
      polymer
      |> Polymer.step_times(10)
      |> Map.get(:occurrences)
      |> Map.values()

    Enum.max(occurrences) - Enum.min(occurrences)
  end

  def part2 do
    data = Helpers.read_lines("data/day_14.txt")
    polymer = Polymer.parse_polymer_data(data)

    occurrences =
      polymer
      |> Polymer.step_times(40)
      |> Map.get(:occurrences)
      |> Map.values()

    Enum.max(occurrences) - Enum.min(occurrences)
  end
end

defmodule Advent.Day14.Polymer do
  alias __MODULE__
  defstruct pairs: %{}, occurrences: %{}, rules: %{}

  def new(polymer_text, rules) do
    occurrences =
      polymer_text
      |> String.codepoints()
      |> Enum.frequencies()

    pairs =
      polymer_text
      |> String.codepoints()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(&Enum.join/1)
      |> Enum.frequencies()

    %Polymer{pairs: pairs, occurrences: occurrences, rules: rules}
  end

  def parse_polymer_data(lines) do
    [start_text | [_ | rules_lines]] = lines

    rules = parse_rules(rules_lines)

    new(start_text, rules)
  end

  def interleave_polymer(polymer) do
    Enum.reduce(polymer.pairs, %Polymer{polymer | pairs: %{}}, fn {pair, count}, acc ->
      insert = polymer.rules[pair]

      new_pairs =
        acc.pairs
        |> Map.update(String.first(pair) <> insert, count, fn c -> c + count end)
        |> Map.update(insert <> String.last(pair), count, fn c -> c + count end)

      new_occur = Map.update(acc.occurrences, insert, 1, fn i -> i + count end)

      acc
      |> Map.put(:pairs, new_pairs)
      |> Map.put(:occurrences, new_occur)
    end)
  end

  def step_times(polymer, steps) do
    Enum.reduce(
      1..steps,
      polymer,
      fn _, acc ->
        interleave_polymer(acc)
      end
    )
  end

  defp parse_rules(rules_lines) do
    for rule <- rules_lines,
        [pair, insert] = Regex.run(~r/([A-Z]{2}) -> ([A-Z])/, rule, capture: :all_but_first),
        into: %{} do
      {pair, insert}
    end
  end
end
