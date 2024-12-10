{:ok, data} = File.read("./input.txt")

{muls, _} = Regex.scan(~r/(mul\([0-9]{1,3}\,[0-9]{1,3}\))|(do\(\))|(don't\(\))/, data, capture: :first)
|> Enum.map(fn [mul] -> mul end)
|> Enum.reduce({[], true}, fn func, {acc, ins} ->
  case func do
    "don't()" -> {acc, false}
    "do()" -> {acc, true}
    func ->
      if ins do
        {[func | acc], ins}
      else
        {acc, ins}
      end
  end
end)

sum = Enum.map(muls, fn mul ->
  Regex.scan(~r/[0-9]+/, mul)
  |> Enum.map(fn [num] -> String.to_integer(num) end)
end)
|> Enum.map(fn [lhs, rhs] -> lhs * rhs end)
|> Enum.sum

IO.inspect(sum)
