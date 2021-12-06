defmodule Day5Test do
  use ExUnit.Case
  import Advent.Day5

  def example do
    [
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2"
    ]
  end

  test "part 1" do
    lines = parse_lines(example())
    assert count_vert_intersections(lines) == 5
  end

  test "part 2" do
    lines = parse_lines(example())
    assert count_intersections(lines) == 12
  end
end
