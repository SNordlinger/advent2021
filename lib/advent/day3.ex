defmodule Advent.Day3 do
  alias Advent.Helpers
  import Bitwise

  def calc_gamma(report) do
    report
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip_with(&calc_most_common_bit/1)
    |> Enum.join()
    |> String.to_integer(2)
  end

  def calc_most_common_bit(bits) do
    if Enum.count(bits, fn b -> b == "1" end) >= Enum.count(bits) / 2 do
      "1"
    else
      "0"
    end
  end

  def calc_epsilon(gamma, bit_len) do
    bnot(gamma) &&& Integer.pow(2, bit_len) - 1
  end

  def calc_oxygen(report) do
    calc_with_bit_criteria(report, &calc_most_common_bit/1, 0)
  end

  def calc_scrubbing(report) do
    criteria = fn bits -> if calc_most_common_bit(bits) == "1", do: "0", else: "1" end
    calc_with_bit_criteria(report, criteria, 0)
  end

  defp calc_with_bit_criteria(report, criteria, pos) do
    key = Enum.map(report, fn s -> String.slice(s, pos, 1) end) |> then(criteria)
    remaining = Enum.filter(report, fn s -> String.slice(s, pos, 1) == key end)

    if Enum.count(remaining) == 1 do
      String.to_integer(hd(remaining), 2)
    else
      calc_with_bit_criteria(remaining, criteria, pos + 1)
    end
  end

  def part1 do
    report = Helpers.read_lines("data/day_3.txt")
    bit_len = String.length(hd(report))
    gamma = calc_gamma(report)
    epsilon = calc_epsilon(gamma, bit_len)
    gamma * epsilon
  end

  def part2 do
    report = Helpers.read_lines("data/day_3.txt")
    oxygen = calc_oxygen(report)
    scrubbing = calc_scrubbing(report)
    oxygen * scrubbing
  end
end
