defmodule AocTest do
  use ExUnit.Case, async: true
  doctest Aoc
  doctest Day01

  test "Day 1, part 1" do
    assert Day01.part_1() == 2_580_760
  end

  test "Day 1, part 2" do
    assert Day01.part_2() == 25_358_365
  end

  test "Day 2, part 1" do
    assert Day02.part_1() == 257
  end

  test "Day 2, part 2" do
    assert Day02.part_1() == 328
  end
end
