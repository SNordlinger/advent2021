defmodule Advent.Day6 do
  alias Advent.Helpers
  alias Advent.Day6.Fish

  def calc_count(fish, days) do
    Enum.reduce(1..days, Fish.new(fish), fn day, prev -> Fish.advance(prev, day) end)
    |> Fish.total()
  end

  def part1 do
    Helpers.read_int_line("data/day_6.txt", ",") |> calc_count(80)
  end

  def part2 do
    Helpers.read_int_line("data/day_6.txt", ",") |> calc_count(256)
  end
end

defmodule Advent.Day6.Fish do
  alias __MODULE__

  init_vals = Map.new(0..6, &{&1, 0})
  defstruct counts: init_vals, next: 0, new: 0

  def new(fishes) do
    Enum.reduce(fishes, %Fish{}, fn fish, acc ->
      prev_count = Map.get(acc.counts, fish, 0)
      put_in(acc.counts[fish], prev_count + 1)
    end)
  end

  def advance(prev, day_num) do
    fish_spawning = rem(day_num - 1, 7)
    spawn_count = prev.counts[fish_spawning]

    %Fish{
      counts: Map.update!(prev.counts, fish_spawning, &(&1 + prev.next)),
      next: prev.new,
      new: spawn_count
    }
  end

  def total(data) do
    total_mature = Map.values(data.counts) |> Enum.sum()

    total_mature + data.next + data.new
  end
end
