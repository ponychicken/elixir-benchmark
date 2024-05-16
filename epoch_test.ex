defmodule EpochTest do
  def run_test do
    timestamps = Enum.to_list(0..99999)

    {time, _} = :timer.tc(fn ->
      Enum.map(timestamps, &NaiveDateTime.from_gregorian_seconds/1)
    end)

    IO.puts("Parsing time: #{time} microseconds")
  end
end
