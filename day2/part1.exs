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

test = File.stream!("./input.txt")
|> Stream.map(fn (line) ->
  String.split(line)
  |> Enum.map(&String.to_integer/1)
end)
|> Enum.to_list
|> Enum.map(&AOC.isSafe/1)
|> Enum.count(fn element -> element end)

IO.inspect(test)
