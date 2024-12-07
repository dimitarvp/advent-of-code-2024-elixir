defmodule Day01 do
  @type id :: non_neg_integer()
  @type pair :: {id(), id()}
  @type pairs :: [pair()]
  @type distance :: non_neg_integer()
  @type similarity :: non_neg_integer()

  @spec sum_of_distances(pairs()) :: distance()
  def sum_of_distances(input) do
    input
    |> Enum.zip_with(&Enum.sort/1)
    |> Enum.zip_reduce(0, fn [a, b], sum -> sum + abs(a - b) end)
  end

  @spec similarity_score(pairs()) :: similarity()
  def similarity_score(input) do
    [left, right] = Enum.zip_with(input, &Enum.frequencies/1) |> dbg()
    Enum.reduce(left, 0, fn {k, v}, sum -> sum + k * v * Map.get(right, k, 0) end) |> dbg()
  end

  @doc ~S"""
  iex> Day01.part_1("3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n")
  11
  """
  @spec part_1(String.t()) :: distance()
  def part_1(input \\ Aoc.input(1)) do
    input |> Aoc.parse_lines_of_integers() |> sum_of_distances()
  end

  @doc ~S"""
  iex> Day01.part_2("3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n")
  31

  iex> Day01.part_2("3   4\n4   3\n2   3\n1   3\n3   9\n3   3\n")
  40
  """
  @spec part_2(String.t()) :: similarity()
  def part_2(input \\ Aoc.input(1)) do
    input |> Aoc.parse_lines_of_integers() |> similarity_score()
  end
end
