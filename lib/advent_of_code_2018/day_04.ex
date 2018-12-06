defmodule AdventOfCode2018.Day04 do
  def part1(args) do
    logs =
      args
      |> String.split("\n", trim: true)
      |> Enum.sort()
      |> extract_logs()

    {guard_id, _} = most_asleep(logs)
    minute = get_most_asleep_minutes(logs[guard_id])

    minute * guard_id
  end

  defp parse_record(record) do
    [_, min, message] =
      record
      |> String.split([":", "] "], trim: true)

    case message do
      "falls asleep" ->
        {:sleep, String.to_integer(min)}

      "wakes up" ->
        {:wake, String.to_integer(min)}

      _ ->
        guard_id =
          String.split(message, [" #", " "])
          |> Enum.at(1)
          |> String.to_integer()

        {:shift, guard_id}
    end
  end

  defp extract_logs(lines) do
    {_, _, logs} =
      lines
      |> Enum.map(&parse_record/1)
      |> Enum.reduce({nil, nil, %{}}, fn log, {current_guard_id, last_minute, slots} ->
        case log do
          {:shift, guard_id} ->
            {guard_id, nil, Map.put_new(slots, guard_id, [])}

          {:sleep, minute} ->
            {current_guard_id, minute, slots}

          {:wake, minute} ->
            new_range = last_minute..(minute - 1)
            {current_guard_id, nil, Map.update!(slots, current_guard_id, &[new_range | &1])}
        end
      end)

    logs
  end

  def most_asleep(logs) do
    Enum.reduce(logs, %{}, fn {id, ranges}, acc ->
      time_asleep = ranges |> Enum.map(&Enum.count/1) |> Enum.sum()
      Map.put(acc, id, time_asleep)
    end)
    |> Enum.max_by(fn {_, count} -> count end)
  end

  defp get_most_asleep_minutes(sleeping_times) do
    {min, _} =
      sleeping_times
      |> Enum.map(&Enum.to_list/1)
      |> List.flatten()
      |> Enum.group_by(& &1)
      |> Enum.max_by(fn {_, list} -> Enum.count(list) end)

    min
  end

  def part2(args) do
  end
end
