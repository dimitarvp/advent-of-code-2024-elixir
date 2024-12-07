defmodule Aoc do
  def parse_line_of_integers(line) do
    line
    |> String.trim()
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
  end

  def parse_lines_of_integers(lines) do
    lines
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line_of_integers/1)
  end

  def input(day) when day in 1..25 do
    File.read!("input/day_#{formatted_day(day)}.txt")
  end

  def formatted_day(day) when day in 1..9 do
    "0" <> Integer.to_string(day)
  end

  def formatted_day(day) when day in 10..25 do
    Integer.to_string(day)
  end
end
