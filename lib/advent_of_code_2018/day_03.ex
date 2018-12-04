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
    for {coordinate, ids = [_, _ | _]} <- claimed_inches(claimed), do: {coordinate, ids}
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> not_overlapping_claim()
  end

  defp not_overlapping_claim(claimed) do
    overlapping_ids =
      claimed
      |> overlapped_inches()
      |> Enum.flat_map(fn {_, ids} -> ids end)
      |> Enum.uniq()
      |> Enum.sort()

    all_ids =
      claimed
      |> Enum.map(&parse_claim/1)
      |> Enum.map(fn [id, _, _, _, _] -> id end)
      |> Enum.uniq()
      |> Enum.sort()
    
    Enum.find(all_ids, fn id -> !Enum.member?(overlapping_ids, id) end)
  end
end
