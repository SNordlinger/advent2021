defmodule Day3Test do
  use ExUnit.Case
  import Advent.Day3

  def report() do
    [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
  end

  test "part 1 gamma" do
    assert calc_gamma(report) == 22
  end

  test "part 1 epslion" do
    assert calc_epsilon(22, 5) == 9
  end

  test "part 2 oxygen" do
    assert calc_oxygen(report) == 23
  end

  test "part 2 scrubbing" do
    assert calc_scrubbing(report) == 10
  end
end
