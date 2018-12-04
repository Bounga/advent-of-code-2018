defmodule AdventOfCode2018.Day03 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> overlapped_inches()
    |> Enum.count()
  end

  defp parse_claim(claim) do
    claim
    |> String.split(["#", " @ ", ",", ": ", "x"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp claimed_inches(list) do
    list
    |> Enum.map(&parse_claim/1)
    |> Enum.reduce(%{}, fn [id, left, top, width, height], acc ->
      Enum.reduce((left + 1)..(left + width), acc, fn x, acc ->
        Enum.reduce((top + 1)..(top + height), acc, fn y, acc ->
          Map.update(acc, {x, y}, [id], &[id | &1])
        end)
      end)
    end)
  end

  defp overlapped_inches(claimed) do
    for {coordinate, [_, _ | _]} <- claimed_inches(claimed), do: coordinate
  end

  def part2(args) do
  end
end
