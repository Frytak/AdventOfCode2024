{:ok, data} = File.read("./input.txt")

muls = Regex.scan(~r/mul\([0-9]{1,3}\,[0-9]{1,3}\)/, data)
|> Enum.map(fn [mul] -> mul end)

sum = Enum.map(muls, fn mul ->
  Regex.scan(~r/[0-9]+/, mul)
  |> Enum.map(fn [num] -> String.to_integer(num) end)
end)
|> Enum.map(fn [lhs, rhs] -> lhs * rhs end)
|> Enum.sum

IO.inspect(sum)
