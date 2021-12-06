defmodule Advent.Day5 do
  alias Advent.Helpers

  def parse_lines(filelines) do
    Enum.map(filelines, fn ln ->
      [x1, y1, x2, y2] =
        Regex.run(~r/([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/, ln, capture: :all_but_first)
        |> Enum.map(&String.to_integer/1)

      {{x1, y1}, {x2, y2}}
    end)
  end

  def expand_line({{x1, y1}, {x2, y2}}) do
    cond do
      x1 == x2 ->
        Enum.map(y1..y2, &{x1, &1})

      y1 == y2 ->
        Enum.map(x1..x2, &{&1, y1})

      true ->
        Enum.zip(x1..x2, y1..y2)
    end
  end

  def count_vert_intersections(lines) do
    lines
    |> Enum.filter(fn {{x1, y1}, {x2, y2}} -> x1 == x2 or y1 == y2 end)
    |> count_intersections()
  end

  def count_intersections(lines) do
    lines
    |> Enum.map(&expand_line/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.count(fn {_, c} -> c > 1 end)
  end

  def part1 do
    Helpers.read_lines('data/day_5.txt')
    |> parse_lines()
    |> count_vert_intersections()
  end

  def part2 do
    Helpers.read_lines('data/day_5.txt')
    |> parse_lines()
    |> count_intersections()
  end
end
