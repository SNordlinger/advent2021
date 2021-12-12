defmodule Day11Test do
  use ExUnit.Case
  import Advent.Day11

  def example_grid() do
    lines = [
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526"
    ]

    # lines = ["11111", "19991", "19191", "19991", "11111"]

    Advent.Day11.OctopusGrid.parse_grid(lines)
  end

  test "part 1" do
    grid = example_grid()
    new_grid = cycle100(grid)
    assert new_grid.flashes == 1656
  end

  test "part 2" do
    grid = example_grid()
    new_grid = cycle_until_sync(grid)
    assert new_grid.step == 195
  end
end
