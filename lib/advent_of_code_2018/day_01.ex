defmodule AdventOfCode2018.Day01 do
  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end

  def part2(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn i, {current, seen} ->
      frequency = current + i

      if MapSet.member?(seen, frequency) do
        {:halt, frequency}
      else
        {:cont, {frequency, MapSet.put(seen, frequency)}}
      end
    end)
  end
end
