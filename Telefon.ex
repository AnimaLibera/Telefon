defmodule Telefon do	

	defp update(record, book) do
		key = elem(record, 0)
		value = elem(record, 1)
		return = Map.fetch(book, key)
		case return do
			{:ok, result} -> 	Map.put(book, key, result + value)
			:error -> Map.put(book, key, value)
		end
	end

	defp convert(record) do
		key = hd(record)
		value = hd(tl(record)) |> Integer.parse()
		{key, elem(value, 0)}
	end

	def book_from_file(name) do
		text = File.read!("./#{name}")
		lines = String.split(text, "\n")
		records = lines |> Enum.map(fn line -> String.split(line, " ") end) |> Enum.map(&(convert(&1)))
		Enum.reduce(records, %{}, fn record, acc -> update(record, acc) end) #book
	end

end