defmodule Advent.Day8 do
  alias Advent.Helpers

  def read_data do
    lines = Helpers.read_lines('data/day_8.txt')

    Enum.map(lines, &parse_line/1)
  end

  def parse_line(line) do
    [pat, out] =
      line
      |> String.split("|")
      |> Enum.map(&String.split/1)

    {pat, out}
  end

  def count_unique_segments(data) do
    outputs =
      data
      |> Enum.map(&elem(&1, 1))
      |> List.flatten()

    Enum.count(outputs, fn out ->
      ln = String.length(out)
      ln == 2 or ln == 3 or ln == 4 or ln == 7
    end)
  end

  def find_nums_from_pattern(pattern) do
    {one, rem} = find_num_from_len(pattern, 2)
    {four, rem} = find_num_from_len(rem, 4)
    {seven, rem} = find_num_from_len(rem, 3)
    {eight, rem} = find_num_from_len(rem, 7)

    {nine, rem} = find_num_from_partial(rem, 6, four)
    {three, rem} = find_num_from_partial(rem, 5, seven)
    {five, rem} = find_num_from_superset(rem, 5, nine)
    {two, rem} = find_num_from_len(rem, 5)
    {six, [zero]} = find_num_from_partial(rem, 6, five)

    [
      {zero, 0},
      {one, 1},
      {two, 2},
      {three, 3},
      {four, 4},
      {five, 5},
      {six, 6},
      {seven, 7},
      {eight, 8},
      {nine, 9}
    ]
  end

  def calc_output({pattern, output}) do
    num_lookup = find_nums_from_pattern(pattern)

    output
    |> Enum.map(&convert(&1, num_lookup))
    |> Enum.zip_with(3..0, fn num, digit -> num * Integer.pow(10, digit) end)
    |> Enum.sum()
  end

  def find_num_from_len(pattern, len) do
    {[num], rem} = Enum.split_with(pattern, &(String.length(&1) == len))

    {num, rem}
  end

  def find_num_from_partial(pattern, len, partial) do
    {[num], rem} =
      Enum.split_with(pattern, fn num ->
        String.length(num) == len and is_partial(num, partial)
      end)

    {num, rem}
  end

  def find_num_from_superset(pattern, len, superset) do
    {[num], rem} =
      Enum.split_with(pattern, fn num ->
        String.length(num) == len and is_partial(superset, num)
      end)

    {num, rem}
  end

  def is_equal(num1, num2) do
    String.length(num1) == String.length(num2) and is_partial(num1, num2)
  end

  def is_partial(num, partial) do
    partial
    |> String.codepoints()
    |> Enum.all?(&String.contains?(num, &1))
  end

  def convert(num, num_lookup) do
    {_, int} = Enum.find(num_lookup, &is_equal(elem(&1, 0), num))

    int
  end

  def part1() do
    data = read_data()
    count_unique_segments(data)
  end

  def part2() do
    read_data()
    |> Enum.map(&calc_output(&1))
    |> Enum.sum()
  end
end
