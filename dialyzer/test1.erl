-module(test1).
-export([f1/0]).

f1() ->
    X = erlang:time(),
    io:format("Erlang Time ~p~n", [X]),
    seconds(X).

seconds({Hour, Min, Sec}) ->
    (Hour * 60 + Min)*60 +Sec.
