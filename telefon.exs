update = fn record, book ->
	key = elem(record, 0)
	value = elem(record, 1)
	flag = Map.fetch(book, key)
	case flag do
		{:ok, result} -> 	Map.put(book, key, result + value)
		:error -> Map.put(book, key, value)
	end
end

convert = fn record ->
	key = hd(record)
	value = hd(tl(record)) |> Integer.parse()
	{key, elem(value, 0)}
end

file_name = "telefon.txt"
text = File.read!("./#{file_name}")
lines = String.split(text, "\n")
records = lines |> Enum.map(fn line -> String.split(line, " ") end) |> Enum.map(convert)
book = Enum.reduce(records, %{}, fn record, acc -> update.(record, acc) end)

IO.puts(inspect(book))