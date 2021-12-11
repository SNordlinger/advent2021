defmodule Day9Test do
  use ExUnit.Case
  import Advent.Day9

  def example_height_map() do
    lines = ["2199943210", "3987894921", "9856789892", "8767896789", "9899965678"]

    parse_height_map(lines)
  end

  test "part 1" do
    heights = example_height_map()
    assert total_risk_level(heights) == 15
  end

  test "part 2" do
    heights = example_height_map()
    basins = find_all_basins(heights)
    IO.inspect(basins)
    assert basin_size_product(basins) == 1134
  end
end
