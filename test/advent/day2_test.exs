defmodule Day2Test do
  use ExUnit.Case
  import Advent.Day2

  test "part 1" do
    cmds = parse_cmd_list(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])

    assert follow_commands({0, 0}, cmds) == {10, 15}
  end

  test "part 2" do
    cmds = parse_cmd_list(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])

    {depth, dist, _} = follow_aim_commands({0, 0, 0}, cmds)
    assert depth == 60
    assert dist == 15
  end
end
