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

  @tag :skip
  test "part2" do
    input = nil 
    result = part2(input)

    assert result
  end
end
