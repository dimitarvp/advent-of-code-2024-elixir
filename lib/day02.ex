defmodule Day02 do
  @moduledoc ~S"""
  A solution to https://adventofcode.com/2024/day/2.
  """

  @type level :: pos_integer()
  @type report :: [level()]

  @spec parse_line(String.t()) :: report()
  def parse_line(line) do
    line
    |> String.trim()
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
  end

  @spec parse_input(String.t()) :: [report()]
  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reject(fn line -> line == "" end)
    |> Enum.map(&parse_line/1)
  end

  @spec monotonically_increasing?(report()) :: boolean()
  def monotonically_increasing?(report) do
    ascending_values = Enum.sort(report, :asc)
    unique_ascending_values = Enum.uniq(ascending_values)
    ascending_values == unique_ascending_values and ascending_values == report
  end

  @spec monotonically_decreasing?(report()) :: boolean()
  def monotonically_decreasing?(report) do
    descending_values = Enum.sort(report, :desc)
    unique_descending_values = Enum.uniq(descending_values)
    descending_values == unique_descending_values and descending_values == report
  end

  @spec monotonically_advancing?(report()) :: boolean()
  def monotonically_advancing?(report) do
    monotonically_increasing?(report) or monotonically_decreasing?(report)
  end

  @spec advancing_with_small_steps?(report()) :: boolean()
  def advancing_with_small_steps?([first | rest]) do
    Enum.reduce(rest, {first, []}, fn current_level, {previous_level, distances} ->
      {current_level, [abs(previous_level - current_level) | distances]}
    end)
    |> then(fn {_last_level, distances} -> distances end)
    # NOTE: We can also check for `distance >= 1` and that eliminates the need for checking
    # for monotonical advancement of the list.
    |> Enum.all?(fn distance -> distance <= 3 end)
  end

  @spec all_variants_with_one_element_removed(report()) :: [report()]
  def all_variants_with_one_element_removed(list) do
    for i <- 0..(length(list) - 1), do: list |> List.delete_at(i)
  end

  @spec safe?(report()) :: boolean()
  def safe?(report) do
    monotonically_advancing?(report) and advancing_with_small_steps?(report)
  end

  @spec safe_with_a_dampener?(report()) :: boolean()
  def safe_with_a_dampener?(report) do
    safe?(report) or
      report |> all_variants_with_one_element_removed() |> Enum.any?(&safe?/1)
  end

  @doc ~S"""
  iex> Day02.part_1("7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9\n")
  nil
  """
  @spec part_1(String.t()) :: non_neg_integer()
  def part_1(input \\ Aoc.input(2)) do
    input
    |> Aoc.parse_lines_of_integers()
    |> Enum.count(&safe?/1)
  end

  def part_2(input \\ Aoc.input(2)) do
    input
    |> Aoc.parse_lines_of_integers()
    |> Enum.count(&safe_with_a_dampener?/1)
  end
end
