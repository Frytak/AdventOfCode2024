{left, right} = File.stream!("./input.txt")
|> Stream.map(fn (line) -> String.split(line) end)
|> Enum.reverse
|> Enum.reduce({[], []}, fn [left, right], {acc1, acc2} ->
  {[String.to_integer(left) | acc1], [String.to_integer(right) | acc2]}
end)
|> (fn {left, right} -> {Enum.sort(left), Enum.sort(right)} end).()

distance = Enum.map(left, fn left ->
  Enum.reduce(right, 0, fn right, acc ->
    if left == right do
      acc + right
    else
      acc
    end
  end)
end)
|> Enum.sum

IO.inspect(distance)
