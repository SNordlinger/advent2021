defmodule Advent.Day2 do
  alias Advent.Helpers

  def next(cmd, {depth, dist}) do
    case cmd do
      {"forward", val} -> {depth, dist + val}
      {"up", val} -> {depth - val, dist}
      {"down", val} -> {depth + val, dist}
    end
  end

  def next_aim(cmd, {depth, dist, aim}) do
    case cmd do
      {"forward", val} ->
        {depth + val * aim, dist + val, aim}

      {"up", val} ->
        {depth, dist, aim - val}

      {"down", val} ->
        {depth, dist, aim + val}
    end
  end

  def follow_commands(start, cmds) do
    Enum.reduce(cmds, start, &next/2)
  end

  def follow_aim_commands(start, cmds) do
    Enum.reduce(cmds, start, &next_aim/2)
  end

  def parse_cmd_list(list) do
    list
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn [cmd, valstr] -> {cmd, String.to_integer(valstr)} end)
  end

  def part1 do
    cmds =
      Helpers.read_lines('data/day_2.txt')
      |> parse_cmd_list()

    follow_commands({0, 0}, cmds)
    |> Tuple.product()
  end

  def part2 do
    cmds =
      Helpers.read_lines('data/day_2.txt')
      |> parse_cmd_list()

    {depth, dist, _} = follow_aim_commands({0, 0, 0}, cmds)
    depth * dist
  end
end
