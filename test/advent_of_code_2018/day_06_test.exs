defmodule AdventOfCode2018.Day06Test do
  use ExUnit.Case
  doctest AdventOfCode2018.Day06

  import AdventOfCode2018.Day06

  test "part1" do
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """
    result = part1(input)

    assert result == 17
  end

  test "part2" do
    max_distance = 32
    input = """
    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    """
    result = part2(input, max_distance)

    assert result == 16
  end
end
