distance = File.stream!("./input.txt")
|> Stream.map(fn (line) -> String.split(line) end)
|> Enum.reverse
|> Enum.reduce({[], []}, fn [left, right], {acc1, acc2} ->
  {[String.to_integer(left) | acc1], [String.to_integer(right) | acc2]}
end)
|> (fn {left, right} -> {Enum.sort(left), Enum.sort(right)} end).()
|> (fn {left, right} -> Enum.zip_reduce(left, right, 0, fn left, right, acc -> acc + abs(left - right) end) end).()

IO.inspect(distance)
