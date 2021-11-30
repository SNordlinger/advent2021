defmodule Day1Test do
  use ExUnit.Case
  import Advent.Day1

  test "part 1" do
    example = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert count_increases(example) == 7
  end

  test "part 2" do
    example = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert count_window_increases(example) == 5
  end
end
