defmodule AOC do
  def isSafe(list) when is_list(list) do
    Enum.chunk_every(list, 3, 1, :discard)
    |> Enum.map(fn [a, b, c] ->
      abs(a - b) in 1..3 && abs(b - c) in 1..3 && (((a < b) && (b < c)) || ((a > b) && (b > c)))
    end)
    |> Enum.reduce(true, fn isChunkSafe, acc -> 
      if !isChunkSafe || !acc do
        false
      else
        true
      end
    end)
  end
end

reports = File.stream!("./input.txt")
|> Stream.map(fn (line) ->
  String.split(line)
  |> Enum.map(&String.to_integer/1)
end)
|> Enum.to_list

possible_reports = Enum.map(reports, fn report ->
  Enum.with_index(report)
  |> Enum.reduce([], fn {element1, index1}, acc ->
    possible_report = Enum.with_index(report)
    |> Enum.reduce([], fn {element2, index2}, acc ->
      if index1 != index2 do
        [element2 | acc]
      else
        acc
      end
    end)
    |> Enum.reverse

    [possible_report | acc]
  end)
end)
|> Enum.map(fn possible_report -> Enum.map(possible_report, &AOC.isSafe/1) end)
|> Enum.map(fn possible_reports ->
  Enum.reduce(possible_reports, false, fn possible_report, acc ->
    if possible_report || acc do
      true
    else
      false
    end
  end)
end)
|> Enum.count(fn element -> element end)

IO.inspect(possible_reports)
