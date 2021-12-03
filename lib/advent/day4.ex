defmodule Advent.Day4 do
  def is_winning_line?(line) do
    Enum.all?(line, fn {_, marked} -> marked end)
  end

  def has_winning_row?(card) do
    Enum.any?(card, &is_winning_line?/1)
  end

  def has_winning_col?(card) do
    card
    |> Enum.zip_with(&is_winning_line?/1)
    |> Enum.any?()
  end

  def is_winner?(card) do
    has_winning_col?(card) || has_winning_row?(card)
  end

  def mark_card(card, called) do
    Enum.map(card, fn row ->
      Enum.map(row, fn {num, marked?} ->
        if num == called, do: {num, true}, else: {num, marked?}
      end)
    end)
  end

  def find_winner(cards, nums) do
    [called | rest] = nums
    marked_cards = Enum.map(cards, fn card -> mark_card(card, called) end)
    winner = Enum.find(marked_cards, &is_winner?/1)

    if winner != nil do
      {winner, called}
    else
      find_winner(marked_cards, rest)
    end
  end

  def find_loser(cards, nums) do
    [called | rest] = nums
    marked_cards = Enum.map(cards, fn card -> mark_card(card, called) end)
    {winners, not_won} = Enum.split_with(marked_cards, &is_winner?/1)

    if !Enum.empty?(winners) && Enum.empty?(not_won) do
      {hd(winners), called}
    else
      find_loser(not_won, rest)
    end
  end

  def score_card(card, last_num) do
    card_sum =
      List.flatten(card)
      |> Enum.filter(fn {_, marked} -> !marked end)
      |> Enum.reduce(0, fn {num, _}, sum -> sum + num end)

    card_sum * last_num
  end

  def parse_card(card_str) do
    lines = String.split(card_str, "\n")

    Enum.map(lines, fn line ->
      String.split(line)
      |> Enum.map(fn n -> {String.to_integer(n), false} end)
    end)
  end

  def read_bingo_file() do
    chunks =
      File.read!("data/day_4.txt")
      |> String.trim()
      |> String.split("\n\n")

    [num_str | card_strs] = chunks

    nums =
      num_str
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    cards = Enum.map(card_strs, &parse_card/1)

    {nums, cards}
  end

  def part1 do
    {nums, cards} = read_bingo_file()
    {winner, last_num} = find_winner(cards, nums)
    score_card(winner, last_num)
  end

  def part2 do
    {nums, cards} = read_bingo_file()
    {loser, last_num} = find_loser(cards, nums)
    score_card(loser, last_num)
  end
end
