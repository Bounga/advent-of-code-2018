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

  def find_twice_and_thrice(characters) do
    Enum.reduce(characters, {0, 0}, fn
      {_codepoint, 2}, {_twice, thrice} -> {1, thrice}
      {_codepoint, 3}, {twice, _thrice} -> {twice, 1}
      _, acc -> acc
    end)
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
    args
    |> String.split("\n", trim: true)
    |> find_closest()
  end

  defp find_closest([head | tail]) do
    if closest = Enum.find_value(tail, &one_difference?(&1, head)) do
      closest
    else
      find_closest(tail)
    end
  end

  defp one_difference?(s1, s2) do
    list1 = String.to_charlist(s1)
    list2 = String.to_charlist(s2)

    zipped =
      list1
      |> Enum.zip(list2)

    zipped
    |> Enum.count(fn {cp1, cp2} -> cp1 != cp2 end)
    |> Kernel.==(1)
    |> case do
         false -> false
         true -> zipped
           |> Enum.reverse()
           |> Enum.reduce([], fn
           {cp1, cp2}, acc when cp1 == cp2 -> [cp1 | acc]
           _, acc -> acc
           end)
           |> to_string()
    end
  end
end
