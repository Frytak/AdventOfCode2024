defmodule AOC do
  def extract(path) do
    {rules, updates, _} = File.stream!(path)
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

    {rules, updates}
  end

  def update_correctnes(update, rules) do
    Enum.with_index(update)
    |> Enum.map(fn {update_num, index} ->
      rules = Map.get(rules, update_num)
      Enum.map(Enum.take(update, index) |> Enum.with_index, fn {update, update_index} ->
        if rules != nil do
          if Enum.member?(rules, update) do
            update_index
          else
            nil
          end
        else
          nil
        end
      end)
    end)
  end

  def is_update_correct(update, rules) do
    update_correctnes(update, rules)
    |> Enum.map(fn x ->
      !Enum.any?(x, fn x -> x != nil end)
    end)
  end

  def fix_update(update, rules) do
    correctnes = update_correctnes(update, rules)
    IO.inspect(update)
    IO.inspect(correctnes)
    IO.inspect(!(is_update_correct(update, rules) |> Enum.member?(false)))
    if (is_update_correct(update, rules) |> Enum.member?(false)) do
      IO.puts(update)
      {index1, index2} = correctnes
      |> List.last
      |> Enum.with_index
      |> Enum.map(fn {x, index} -> {x, index + 1} end)
      |> Enum.reverse
      |> Enum.find(fn {x, _} -> !is_nil(x) end)
      IO.inspect("test2")

      fix_update(swap(update, index1, index2), rules)
    else
      update
    end
  end

  def swap(update, index1, index2) do
    element1 = Enum.at(update, index1)
    element2 = Enum.at(update, index2)

    update
    |> List.replace_at(index1, element2)
    |> List.replace_at(index2, element1)
  end
end

# Operations on lists of booleans
defmodule BoolList do
  def _and(list) do
    Enum.map(list, fn value ->
      !Enum.member?(value, false)
    end)
  end
end
