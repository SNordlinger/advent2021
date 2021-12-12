defmodule Advent.Day11 do
  alias Advent.Helpers
  alias Advent.Day11.OctopusGrid

  def cycle100(grid) do
    Enum.reduce(1..100, grid, fn _, acc ->
      OctopusGrid.step(acc)
    end)
  end

  def cycle_until_sync(grid) do
    new_grid = OctopusGrid.step(grid)

    if OctopusGrid.all_flashed?(new_grid) do
      new_grid
    else
      cycle_until_sync(new_grid)
    end
  end

  def part1() do
    Helpers.read_lines('data/day_11.txt')
    |> OctopusGrid.parse_grid()
    |> cycle100()
    |> Map.get(:flashes)
  end

  def part2() do
    Helpers.read_lines('data/day_11.txt')
    |> OctopusGrid.parse_grid()
    |> cycle_until_sync()
    |> Map.get(:step)
  end
end

defmodule Advent.Day11.OctopusGrid do
  alias __MODULE__
  alias Advent.Helpers

  defstruct octopuses: %{}, flashes: 0, step: 0

  def parse_grid(lines) do
    octopuses = Helpers.parse_int_grid(lines)
    %OctopusGrid{octopuses: octopuses}
  end

  def step(grid) do
    grid
    |> Map.put(:step, grid.step + 1)
    |> inc_all()
    |> flash()
  end

  def inc(grid, loc) do
    if Map.has_key?(grid.octopuses, loc) do
      octopuses = Map.update!(grid.octopuses, loc, &(&1 + 1))
      %{grid | octopuses: octopuses}
    else
      grid
    end
  end

  def reset(grid, loc) do
    if Map.has_key?(grid.octopuses, loc) do
      octopuses = Map.put(grid.octopuses, loc, 0)
      %{grid | octopuses: octopuses}
    else
      grid
    end
  end

  def all_flashed?(grid) do
    Enum.all?(grid.octopuses, fn {_, val} -> val == 0 end)
  end

  defp inc_all(grid) do
    Enum.reduce(grid.octopuses, grid, fn {loc, _}, new_grid ->
      inc(new_grid, loc)
    end)
  end

  defp flash(grid) do
    flasher = Enum.find(grid.octopuses, fn {_, val} -> val > 9 end)

    if flasher != nil do
      {flash_loc, _} = flasher
      grid = reset(grid, flash_loc)
      grid = %{grid | flashes: grid.flashes + 1}

      grid =
        Enum.reduce(surrounding(flash_loc), grid, fn loc, acc ->
          if acc.octopuses[loc] != 0 do
            inc(acc, loc)
          else
            acc
          end
        end)

      flash(grid)
    else
      grid
    end
  end

  defp surrounding({x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
  end
end
