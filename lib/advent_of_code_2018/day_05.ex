defmodule AdventOfCode2018.Day05 do
  @distance ?a - ?A
  
  def part1(args) do
    args
    |> String.trim
    |> kill_adjacent_opposites([])
    |> String.length()
  end

  defp kill_adjacent_opposites(<<l1, rest::binary>>, [l2 | acc]) when abs(l1 - l2) == @distance do
      kill_adjacent_opposites(rest, acc)
  end

  defp kill_adjacent_opposites(<<l1, rest::binary>>, acc) do
    kill_adjacent_opposites(rest, [l1 | acc])
  end

  defp kill_adjacent_opposites(<<>>, acc) do
    acc |> Enum.reverse |> List.to_string
  end
  
  def part2(args) do
  end
end
