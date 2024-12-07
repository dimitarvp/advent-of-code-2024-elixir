defmodule Day01 do
  @type id :: non_neg_integer()
  @type pair :: {id(), id()}
  @type pairs :: [pair()]
  @type distance :: non_neg_integer()
  @type similarity :: non_neg_integer()

  @spec parse_line(String.t()) :: pair()
  def parse_line(line) do
    line
    |> String.trim()
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  @spec parse_input(String.t()) :: [pair()]
  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reject(fn line -> line == "" end)
    |> Enum.map(&parse_line/1)
  end

  @spec sum_of_distances(pairs()) :: distance()
  def sum_of_distances(input) do
    {left, right} = Enum.unzip(input)
    left = Enum.sort(left)
    right = Enum.sort(right)

    left
    |> Enum.zip(right)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  # @spec similarity_score(pairs()) :: similarity()
  def similarity_score(input) do
    {left, right} = Enum.unzip(input)
    frequencies = Enum.frequencies(right)

    left
    |> Enum.map(fn n -> n * Map.get(frequencies, n, 0) end)
    |> Enum.sum()
  end

  @doc ~S"""
  iex> Day01.part_1("3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n")
  11
  """
  @spec part_1(String.t()) :: distance()
  def part_1(input \\ input()) do
    input |> parse_input() |> sum_of_distances()
  end

  @doc ~S"""
  iex> Day01.part_2("3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n")
  31

  iex> Day01.part_2("3   4\n4   3\n2   3\n1   3\n3   9\n3   3\n")
  40
  """
  @spec part_2(String.t()) :: similarity()
  def part_2(input \\ input()) do
    input |> parse_input() |> similarity_score()
  end

  def input(), do: File.read!("input/day_01.txt")
end
