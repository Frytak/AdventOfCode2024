Code.require_file("mod.exs", "./")

{rules, updates} = AOC.extract("./input.txt")

# Check what updates are correct
correctnes = Enum.map(updates, fn update ->
  AOC.is_update_correct(update, rules)
end)
|> BoolList._and

IO.inspect(correctnes)

# Sum up middle number of correct updates
sum = Enum.with_index(correctnes)
|> Enum.reduce(0, fn {correct, index}, acc ->
  if correct do
    update = Enum.at(updates, index)
    acc + Enum.at(update, div(Enum.count(update), 2))
  else 
    acc
  end
end)

IO.inspect(sum)
