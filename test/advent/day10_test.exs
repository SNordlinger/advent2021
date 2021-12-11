defmodule Day10Test do
  use ExUnit.Case
  import Advent.Day10

  def example_input do
    String.split("[({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]")
  end

  test "find error" do
    line = String.codepoints("{([(<{}[<>[]}>{[]{[(<()>")
    assert find_error(line) == {:error, "]", "}"}
  end

  test "part 1" do
    lines = example_input() |> Enum.map(&String.codepoints/1)
    assert calc_error_score(lines) == 26397
  end

  test "part 2" do
    lines = example_input() |> Enum.map(&String.codepoints/1)
    assert calc_missing_score(lines) == 288_957
  end
end
