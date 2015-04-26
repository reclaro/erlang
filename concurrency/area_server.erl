-module(area_server).
-export([loop/0]).

loop() ->
    receive
        {From, rectangle, Width, Ht} ->
            io:format("Area of rectangle is ~p~n", [Width * Ht]),
            From ! [Width * Ht],
            loop();
        {From, square, Side} ->
            io:format("Area of square is~p~n", [Side * Side]),
            From! Side * Side,
            loop()
    end.


