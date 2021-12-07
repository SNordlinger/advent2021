defmodule Day7Test do
  use ExUnit.Case
  import Advent.Day7

  test "part 2" do
    positions = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
    assert find_min_fuel_use(positions) == 168
  end
end
