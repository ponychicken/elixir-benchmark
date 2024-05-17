timestamps = Enum.to_list(0..99999) |> Enum.map(&(&1 + 63_883_170_836))

map_fun = fn i -> [i, i * i] end

Benchee.run(
  %{
    "erlang" => fn -> Enum.map(timestamps, &:calendar.gregorian_seconds_to_datetime/1) end,
    "elixir" => fn -> Enum.map(timestamps, &NaiveDateTime.from_gregorian_seconds/1) end
  }
)
