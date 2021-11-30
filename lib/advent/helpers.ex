defmodule Advent.Helpers do
  def read_int_lines(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.to_list()
  end
end
