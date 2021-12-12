defmodule Advent.Day12 do
  alias Advent.Helpers
  alias Advent.Day12.Path

  def part1 do
    Helpers.read_lines("data/day_12.txt")
    |> Path.new()
    |> Path.routes_to_end()
    |> Enum.count()
  end

  def part2 do
    Helpers.read_lines("data/day_12.txt")
    |> Path.new(true)
    |> Path.routes_to_end()
    |> Enum.count()
  end
end

defmodule Advent.Day12.Path do
  alias __MODULE__

  defstruct connections: %{}, route: ["start"], extra_visit: false

  def new(connection_map, extra_visit \\ false) do
    connections =
      Enum.reduce(connection_map, %{}, fn conn_str, conn ->
        [p1, p2] = Regex.run(~r/([[:alpha:]]+)-([[:alpha:]]+)/, conn_str, capture: :all_but_first)

        conn
        |> Map.update(p1, [p2], fn p -> [p2 | p] end)
        |> Map.update(p2, [p1], fn p -> [p1 | p] end)
      end)

    %Path{connections: connections, extra_visit: extra_visit}
  end

  def add(path, pt) do
    new_path = %{path | route: [pt | path.route]}

    if String.downcase(pt) == pt and Enum.member?(path.route, pt) do
      %{new_path | extra_visit: false}
    else
      new_path
    end
  end

  def possible_next(path) do
    cur = hd(path.route)
    connected = path.connections[cur]

    valid =
      Enum.reject(connected, fn pt ->
        pt == "start" or
          (!path.extra_visit and String.downcase(pt) == pt and Enum.member?(path.route, pt))
      end)

    Enum.map(valid, &add(path, &1))
  end

  def routes_to_end(path) do
    cur = hd(path.route)

    if cur == "end" do
      [path]
    else
      poss = possible_next(path)
      Enum.flat_map(poss, &routes_to_end/1)
    end
  end
end
