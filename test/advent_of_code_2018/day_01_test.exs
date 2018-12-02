defmodule AdventOfCode2018.Day01Test do
  use ExUnit.Case

  import AdventOfCode2018.Day01

  test "part1" do
    input = "+1
-2
+3
+1" 
    result = part1(input)

    assert result == 3

    input = "+1
+1
+1" 
    result = part1(input)

    assert result == 3

    input = "+1
+1
-2" 
    result = part1(input)

    assert result == 0

    input = "-1
-2
-3" 
    result = part1(input)

    assert result == -6
  end

  test "part2" do
    input = "+1
-1" 
    result = part2(input)

    assert result == 0

    input = "+3
+3
+4
-2
-4" 
    result = part2(input)

    assert result == 10

    input = "-6
+3
+8
+5
-6" 
    result = part2(input)

    assert result == 5

    input = "+7
+7
-2
-7
-4" 
    result = part2(input)

    assert result == 14
  end
end
