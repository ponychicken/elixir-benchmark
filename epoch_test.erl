-module(epoch_test).
-export([run_test/0]).

run_test() ->
    Timestamps = lists:seq(0, 99999),

    {Time, _} = timer:tc(fun() ->
        lists:map(fun calendar:gregorian_seconds_to_datetime/1, Timestamps)
    end),

    io:format("Parsing time: ~p microseconds~n", [Time]).
