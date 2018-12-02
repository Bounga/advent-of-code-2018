defmodule AdventOfCode2018.Day01 do
  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end

  def part2(args) do
    list =
      args
      |> String.split("\n")
      |> Enum.map(fn el -> String.to_integer(el) end)

    frequency(list, [0], list)
  end

  defp frequency([], seen, list) do
    frequency(list, seen, list)
  end
  
  defp frequency([head | tail], seen, list) do
    current = List.first(seen) + head

    if Enum.member?(seen, current) do
      current
    else
      frequency(tail, [current | seen], list)
    end
  end
end
