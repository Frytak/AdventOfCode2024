Code.require_file("mod.exs", "./")

{rules, updates} = AOC.extract("./input.txt")

# Fix all the updates
#correctnes = Enum.map(updates, fn update ->
#  AOC.fix_update(update, rules)
#end)

test = updates
|> Enum.at(4)
|> AOC.fix_update(rules)
IO.inspect(test)

## Sum up middle number of correct updates
#sum = Enum.with_index(correctnes)
#|> Enum.reduce(0, fn {correct, index}, acc ->
#  if correct do
#    update = Enum.at(updates, index)
#    acc + Enum.at(update, div(Enum.count(update), 2))
#  else 
#    acc
#  end
#end)
#
#IO.inspect(sum)
