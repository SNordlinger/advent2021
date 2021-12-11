defmodule Advent.Day9 do
  alias Advent.Helpers

  def parse_height_map(lines) do
    lines
    |> Enum.with_index()
    |> Enum.map(fn {line, row_num} -> parse_row(line, row_num) end)
    |> List.flatten()
    |> Map.new()
  end

  def parse_row(line, row_num) do
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {val, col_num} -> {{col_num, row_num}, val} end)
  end

  def find_valleys(height_map) do
    Enum.filter(height_map, fn {coords, height} ->
      is_valley(height, coords, height_map)
    end)
  end

  def is_valley(height, {x, y}, height_map) do
    top = Access.get(height_map, {x, y - 1})
    left = Access.get(height_map, {x - 1, y})
    right = Access.get(height_map, {x + 1, y})
    bottom = Access.get(height_map, {x, y + 1})

    [top, left, bottom, right]
    |> Enum.reject(&is_nil/1)
    |> Enum.all?(&(&1 > height))
  end

  def total_risk_level(height_map) do
    find_valleys(height_map)
    |> Enum.map(fn {_, height} -> height + 1 end)
    |> Enum.sum()
  end

  def find_basin(height_map, coords) do
    find_basin(height_map, coords, MapSet.new([coords]))
  end

  @spec find_basin(nil | maybe_improper_list | map, {number, number}, any) :: any
  def find_basin(height_map, coords, points) do
    {x, y} = coords

    basin_neighbors =
      [{x, y - 1}, {x - 1, y}, {x + 1, y}, {x, y + 1}]
      |> Enum.reject(fn n -> MapSet.member?(points, n) end)
      |> Enum.reject(&(Access.get(height_map, &1) == nil))
      |> Enum.reject(&(Access.get(height_map, &1) == 9))

    new_basin = MapSet.put(points, coords)

    Enum.reduce(basin_neighbors, new_basin, fn loc, acc ->
      find_basin(height_map, loc, acc)
    end)
  end

  def find_all_basins(height_map) do
    find_valleys(height_map)
    |> Enum.map(fn {coords, _} -> coords end)
    |> Enum.map(&find_basin(height_map, &1))
  end

  def basin_size_product(basins) do
    basins
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part1 do
    Helpers.read_lines('data/day_9.txt')
    |> parse_height_map()
    |> total_risk_level()
  end

  def part2 do
    Helpers.read_lines('data/day_9.txt')
    |> parse_height_map()
    |> find_all_basins()
    |> basin_size_product()
  end
end
