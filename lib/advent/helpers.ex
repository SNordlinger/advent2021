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

  def read_int_line(path, separator) do
    File.read!(path)
    |> String.trim()
    |> String.split(separator)
    |> Enum.map(&String.to_integer/1)
  end
end
