{:ok, data} = File.read("./input.txt")

count = File.stream!("./input.txt")
|> Enum.count

xmas = Regex.scan(~r/(?=(XMAS))/, data) |> Enum.count
xmas2 = Regex.scan(~r/(?=(SAMX))/, data) |> Enum.count
xmas3 = Regex.scan(~r/(?=(X(.|\n|\r){#{count + 1}}M(.|\n|\r){#{count + 1}}A(.|\n|\r){#{count + 1}}S))/, data) |> Enum.count
xmas4 = Regex.scan(~r/(?=(S(.|\n|\r){#{count + 1}}A(.|\n|\r){#{count + 1}}M(.|\n|\r){#{count + 1}}X))/, data) |> Enum.count
xmas5 = Regex.scan(~r/(?=(X(.|\n|\r){#{count}}M(.|\n|\r){#{count}}A(.|\n|\r){#{count}}S))/, data) |> Enum.count
xmas6 = Regex.scan(~r/(?=(S(.|\n|\r){#{count}}A(.|\n|\r){#{count}}M(.|\n|\r){#{count}}X))/, data) |> Enum.count
xmas7 = Regex.scan(~r/(?=(X(.|\n|\r){#{count - 1}}M(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}S))/, data) |> Enum.count
xmas8 = Regex.scan(~r/(?=(S(.|\n|\r){#{count - 1}}A(.|\n|\r){#{count - 1}}M(.|\n|\r){#{count - 1}}X))/, data) |> Enum.count

IO.inspect(xmas + xmas2 + xmas3 + xmas4 + xmas5 + xmas6 + xmas7 + xmas8)
