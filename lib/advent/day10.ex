defmodule Advent.Day10 do
  alias Advent.Helpers

  def is_closing?(chr) do
    String.match?(chr, ~r/[\)\]\>\}]/)
  end

  def find_error(chrs) do
    find_error(chrs, [])
  end

  def find_error(chrs, open) do
    cur = List.first(chrs)
    to_close = List.first(open, nil)

    cond do
      Enum.empty?(chrs) ->
        {:missing, open}

      is_closing?(cur) and to_close != cur ->
        {:error, to_close, cur}

      is_closing?(cur) ->
        find_error(Enum.drop(chrs, 1), Enum.drop(open, 1))

      true ->
        find_error(Enum.drop(chrs, 1), [closing_bracket(cur) | open])
    end
  end

  def closing_bracket(open_chr) do
    case open_chr do
      "[" -> "]"
      "(" -> ")"
      "{" -> "}"
      "<" -> ">"
    end
  end

  def error_points({_, _, chr}) do
    case chr do
      ")" -> 3
      "]" -> 57
      "}" -> 1197
      ">" -> 25137
    end
  end

  def missing_points({_, missing}) do
    Enum.reduce(missing, 0, fn chr, acc ->
      case chr do
        ")" -> acc * 5 + 1
        "]" -> acc * 5 + 2
        "}" -> acc * 5 + 3
        ">" -> acc * 5 + 4
      end
    end)
  end

  def calc_error_score(lines) do
    lines
    |> Enum.map(&find_error/1)
    |> Enum.filter(&(elem(&1, 0) == :error))
    |> Enum.map(&error_points/1)
    |> Enum.sum()
  end

  @spec calc_missing_score(any) :: any
  def calc_missing_score(lines) do
    point_totals =
      lines
      |> Enum.map(&find_error/1)
      |> Enum.filter(&(elem(&1, 0) == :missing))
      |> Enum.map(&missing_points/1)
      |> Enum.sort()

    middle_index = div(Enum.count(point_totals), 2)
    Enum.at(point_totals, middle_index)
  end

  def part1 do
    Helpers.read_lines('data/day_10.txt')
    |> Enum.map(&String.codepoints/1)
    |> calc_error_score()
  end

  def part2 do
    Helpers.read_lines('data/day_10.txt')
    |> Enum.map(&String.codepoints/1)
    |> calc_missing_score()
  end
end
