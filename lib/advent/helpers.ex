defmodule Advent.Helpers do
  def read_int_lines(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  def read_lines(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.to_list()
  end

  def read_ints(path, separator) do
    File.read!(path)
    |> String.trim()
    |> String.split(separator)
    |> Enum.map(&String.to_integer/1)
  end

  def parse_int_grid(lines) do
    lines
    |> Enum.with_index()
    |> Enum.map(fn {line, row_num} -> parse_row(line, row_num) end)
    |> List.flatten()
    |> Map.new()
  end

  defp parse_row(line, row_num) do
    line
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {val, col_num} -> {{col_num, row_num}, val} end)
  end
end
