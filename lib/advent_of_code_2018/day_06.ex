defmodule AdventOfCode2018.Day06 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_coordinate/1)
    |> closest()
    |> largest_area()
  end

  @doc """
  Parse coordinate.

  ## Examples
      iex> AdventOfCode2018.Day06.parse_coordinate("1, 3")
      {1, 3}
  """
  def parse_coordinate(binary) when is_binary(binary) do
    [x, y] = String.split(binary, ", ")
    {String.to_integer(x), String.to_integer(y)}
  end

  @doc """
  Gets the bounding box for a list of coordinates.

  ## Examples
      iex> AdventOfCode2018.Day06.bounding_box([
      ...>   {1, 1},
      ...>   {1, 6},
      ...>   {8, 3},
      ...>   {3, 4},
      ...>   {5, 5},
      ...>   {8, 9}
      ...> ])
      {1..8, 1..9}
  """
  def bounding_box(coordinates) do
    {{min_x, _}, {max_x, _}} = Enum.min_max_by(coordinates, &elem(&1, 0))
    {{_, min_y}, {_, max_y}} = Enum.min_max_by(coordinates, &elem(&1, 1))
    {min_x..max_x, min_y..max_y}
  end

  @doc """
  Returns closest coordinates for each grid point

  ## Examples
      iex> AdventOfCode2018.Day06.closest([{1, 1}, {3, 3}])
      {
        %{
          {1, 1} => {1, 1},
          {1, 2} => {1, 1},
          {1, 3} => nil,
          {2, 1} => {1, 1},
          {2, 2} => nil,
          {2, 3} => {3, 3},
          {3, 1} => nil,
          {3, 2} => {3, 3},
          {3, 3} => {3, 3}
         },
         MapSet.new([{1,1}, {3,3}])
       } 
  """
  def closest(coordinates) do
    {x_range, y_range} = bounding_box(coordinates)

    grid =
      for x <- x_range,
          y <- y_range,
          point = {x, y},
          do: {point, classify_coordinates(coordinates, point)},
          into: %{}

    infinites = infinite_coordinates(grid, x_range, y_range)

    {grid, infinites}
  end

  @doc """
  Returns coordinates that are in an infinite area.

  ## Examples
      iex> {grid, _} = AdventOfCode2018.Day06.closest([{1, 1}, {3, 3}, {5, 5}])
      iex> set = AdventOfCode2018.Day06.infinite_coordinates(grid, 1..5, 1..5)
      iex> Enum.sort(set)
      [{1, 1}, {5, 5}]
  """
  def infinite_coordinates(grid, x_range, y_range) do
    infinite_for_x =
      for y <- [y_range.first, y_range.last],
          x <- x_range,
          closest = grid[{x, y}],
          do: closest

    infinite_for_y =
      for x <- [x_range.first, x_range.last],
          y <- y_range,
          closest = grid[{x, y}],
          do: closest

    MapSet.new(infinite_for_x ++ infinite_for_y)
  end

  def largest_area({closest, infinites}) do
    largest =
      closest
      |> Enum.group_by(&elem(&1, 1))
      |> Enum.reject(fn({k, _}) -> k in infinites end)
      |> Enum.max_by(&Enum.count(elem(&1, 1)))

    Enum.count(elem(largest, 1))
  end

  defp classify_coordinates(coordinates, point) do
    coordinates
    |> Enum.map(&{manhattan_distance(&1, point), &1})
    |> Enum.sort()
    |> case do
      [{0, coordinate} | _] -> coordinate
      [{distance, _}, {distance, _} | _] -> nil
      [{_, coordinate} | _] -> coordinate
    end
  end

  defp manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def part2(args) do
  end
end
