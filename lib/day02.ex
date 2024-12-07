defmodule Day02 do
  @moduledoc ~S"""
  A solution to https://adventofcode.com/2024/day/2.
  """

  @type level :: pos_integer()
  @type distance :: integer()
  @type report :: [level()]

  @spec all_variants_with_one_element_removed(report()) :: [report()]
  def all_variants_with_one_element_removed(list) do
    for i <- 0..(length(list) - 1), do: list |> List.delete_at(i)
  end

  @spec sign(integer()) :: :zero | :minus | :plus
  def sign(0), do: :zero
  def sign(i) when i > 0, do: :plus
  def sign(i) when i < 0, do: :minus

  @spec distances(report()) :: [distance()]
  def distances([first | rest]) do
    rest
    |> Enum.reduce({first, []}, fn current_level, {previous_level, distances} ->
      {current_level, [current_level - previous_level | distances]}
    end)
    |> then(fn {_last_level, distances} -> Enum.reverse(distances) end)
  end

  @spec same_signs?([distance()]) :: boolean()
  def same_signs?(list) do
    list
    |> Enum.map(&sign/1)
    |> Enum.uniq()
    |> length()
    |> Kernel.==(1)
  end

  @spec safe?(report()) :: boolean()
  def safe?(report) do
    distances = distances(report)
    monotonical? = same_signs?(distances)

    safely_advancing? =
      distances |> Enum.map(&abs/1) |> Enum.all?(fn distance -> distance <= 3 end)

    monotonical? and safely_advancing?
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

  @spec part_2(String.t()) :: non_neg_integer()
  def part_2(input \\ Aoc.input(2)) do
    input
    |> Aoc.parse_lines_of_integers()
    |> Enum.count(&safe_with_a_dampener?/1)
  end
end
