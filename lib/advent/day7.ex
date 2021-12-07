defmodule Advent.Day7 do
  alias Advent.Helpers

  def calc_fuel_use(start, dest) do
    Enum.sum(1..abs(dest - start))
  end

  def calc_total_use(positions, dest) do
    Enum.reduce(positions, 0, fn pos, acc -> acc + calc_fuel_use(pos, dest) end)
  end

  def find_min_fuel_use(positions) do
    0..Enum.max(positions)
    |> Enum.map(fn dest -> calc_total_use(positions, dest) end)
    |> Enum.min()
  end

  def part2 do
    positions = Helpers.read_ints("data/day_7.txt", ",")
    find_min_fuel_use(positions)
  end
end
