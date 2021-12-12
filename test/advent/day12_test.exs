defmodule Day12Test do
  use ExUnit.Case
  import Advent.Day12
  alias Advent.Day12.Path

  def example_1, do: ["start-A", "start-b", "A-c", "A-b", "b-d", "A-end", "b-end"]

  test "part 1" do
    path_start = Path.new(example_1())
    poss_paths = Path.routes_to_end(path_start)
    assert Enum.count(poss_paths) == 10
  end

  test "part 2" do
    path_start = Path.new(example_1(), true)
    poss_paths = Path.routes_to_end(path_start)
    assert Enum.count(poss_paths) == 36
  end
end
