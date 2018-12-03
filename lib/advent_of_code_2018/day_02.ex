defmodule AdventOfCode2018.Day02 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> checksum()
  end

  def count_codepoints(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn el, acc -> Map.update(acc, el, 1, &(&1 + 1)) end)
  end

  def find_twice_and_thrice(map) do
    values = Map.values(map)
    twice = if Enum.find_value(values, &(&1 == 2)), do: 1, else: 0
    thrice = if Enum.find_value(values, &(&1 == 3)), do: 1, else: 0

    {twice, thrice}
  end

  defp checksum(list) do
    {twices, thrices} =
      Enum.reduce(list, {0, 0}, fn box_id, {total_twice, total_thrice} ->
        {twice, thrice} = box_id |> count_codepoints() |> find_twice_and_thrice()
        {twice + total_twice, thrice + total_thrice}
      end)

    twices * thrices
  end

  def part2(args) do
  end
end
