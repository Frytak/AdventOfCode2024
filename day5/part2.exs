# Operations on lists of booleans
defmodule BoolList do
  def _and(list) do
    Enum.map(list, fn value ->
      !Enum.member?(value, false)
    end)
  end
end

{rules, updates, _} = File.stream!("./input.txt")
|> Enum.reduce({%{}, [], true}, fn line, {rules, updates, is_rules} ->
  line = String.trim(line)

  if is_rules do
    if String.length(line) != 0 do
      [for, rule] = String.split(line, "|") |> Enum.map(&String.to_integer/1)

      {_, rules} = Map.get_and_update(rules, for, fn existing_rules ->
        if existing_rules == nil do
          {existing_rules, [rule]}
        else
          {existing_rules, [rule | existing_rules]}
        end
      end)

      {rules, updates, true}
    else
      {rules, updates, false}
    end
  else
    new_update = String.split(line, ",")
    |> Enum.map(&String.to_integer/1)

    {rules, [new_update | updates], false}
  end
end)

updates = Enum.reverse(updates)

correctnes = Enum.map(updates, fn update ->
  Enum.with_index(update)
  |> Enum.map(fn {update_num, index} ->
    rules = Map.get(rules, update_num)
    Enum.map(Enum.take(update, index), fn update ->
      if rules != nil do
        !Enum.member?(rules, update)
      else
        true
      end
    end)
  end)
end)

IO.inspect(correctnes)

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
