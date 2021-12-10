defmodule Day8Test do
  use ExUnit.Case
  import Advent.Day8

  test "part 2" do
    line = parse_line("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
    cdfeb fcadb cdfeb cdbaf")

    assert calc_output(line) == 5353
  end
end
