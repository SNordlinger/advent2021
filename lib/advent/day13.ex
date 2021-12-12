defmodule Advent.Day13 do
  alias Advent.Helpers

  def parse(data) do
    [grid_text, inst_text] = String.split(data, "\n\n")

    grid =
      grid_text
      |> String.split("\n")
      |> parse_grid()

    inst =
      inst_text
      |> String.split("\n")
      |> parse_inst()

    {grid, inst}
  end

  def fold(grid, inst) do
    for {x, y} <- grid, into: MapSet.new() do
      case inst do
        {"x", pos} when x > pos -> {pos * 2 - x, y}
        {"y", pos} when y > pos -> {x, pos * 2 - y}
        _ -> {x, y}
      end
    end
  end

  def all_folds(grid, instrucitons) do
    Enum.reduce(instrucitons, grid, fn inst, acc -> fold(acc, inst) end)
  end

  def output(grid) do
    {max_x, _} = Enum.max_by(grid, fn {x, _} -> x end)
    {_, max_y} = Enum.max_by(grid, fn {_, y} -> y end)

    for y <- 0..max_y do
      for x <- 0..max_x, into: "" do
        if MapSet.member?(grid, {x, y}), do: "0", else: " "
      end
    end
  end

  def part1 do
    data = File.read!("data/day_13.txt") |> String.trim()
    {grid, inst} = parse(data)
    fold(grid, hd(inst)) |> MapSet.size()
  end

  def part2 do
    data = File.read!("data/day_13.txt") |> String.trim()
    {grid, inst} = parse(data)

    all_folds(grid, inst)
    |> output()
  end

  defp parse_inst(lines) do
    for ln <- lines,
        [dir, pos] = Regex.run(~r/([xy])=([0-9]+)/, ln, capture: :all_but_first) do
      {dir, String.to_integer(pos)}
    end
  end

  defp parse_grid(lines) do
    for ln <- lines,
        [x, y] = Regex.run(~r/([0-9]+),([0-9]+)/, ln, capture: :all_but_first),
        into: MapSet.new() do
      {String.to_integer(x), String.to_integer(y)}
    end
  end
end
