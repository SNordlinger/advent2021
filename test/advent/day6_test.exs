defmodule Day6Test do
  use ExUnit.Case
  import Advent.Day6

  test "part 1" do
    fish = [3, 4, 3, 1, 2]
    assert calc_count(fish, 80) === 5934
  end
end
