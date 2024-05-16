timestamps = Enum.to_list(0..99999)

{time, _} = :timer.tc(fn ->
  Enum.map(timestamps, &NaiveDateTime.from_gregorian_seconds/1)
end)

IO.puts("Parsing time: #{time} microseconds")
time
