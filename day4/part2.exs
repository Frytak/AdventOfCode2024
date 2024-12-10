{:ok, data} = File.read("./input.txt")

count = File.stream!("./input.txt")
|> Enum.count

xmas = Regex.scan(~r/(?=(M.S(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}M.S))/, data) |> Enum.count
xmas2 = Regex.scan(~r/(?=(M.M(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}S.S))/, data) |> Enum.count
xmas3 = Regex.scan(~r/(?=(S.M(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}S.M))/, data) |> Enum.count
xmas4 = Regex.scan(~r/(?=(S.S(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}M.M))/, data) |> Enum.count

IO.inspect(xmas + xmas2 + xmas3 + xmas4)
