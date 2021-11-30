defmodule Advent.Day1 do
  def count_increases(depths) do
    Enum.zip(Enum.drop(depths, -1), Enum.drop(depths, 1))
    |> Enum.count(fn {first, second} -> second > first end)
  end

  def count_window_increases(depths) do
    first = Enum.drop(depths, -2)

    middle =
      depths
      |> Enum.drop(-1)
      |> Enum.drop(1)

    last = Enum.drop(depths, 2)

    Enum.zip([first, middle, last])
    |> Enum.map(fn window -> Tuple.sum(window) end)
    |> count_increases()
  end

  def part1() do
    Advent.Helpers.read_int_lines("data/day_1.txt")
    |> count_increases
  end

  def part2() do
    Advent.Helpers.read_int_lines("data/day_1.txt")
    |> count_window_increases
  end
end
