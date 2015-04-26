-module(ringmxg).

-export([start/2, create/2]).

start(Nodes, Laps) ->
    io:format("Going to create a ring with ~p nodes and pass mex ~p times~n",
              [Nodes, Laps]),
    Mex = "I am the Mex",
    NextNode = spawn(ringmxg, create, [self(), Nodes-2]),
    io:format("I am the first ~p~n", [self()]),
    NextNode ! {self(), Laps-1, Mex},
    loop(NextNode).


create(FirstNode, 0) ->
    io:format("I am the last process ~p~n", [self()]),
    loop(FirstNode);

create(FirstNode, Nodes) ->
    % create a new Nodes if Nodes is not 0
    io:format("Spawing a new process~n"),
    NextNode = spawn(ringmxg, create, [FirstNode, Nodes-1]),
    io:format("I am ~p pid and left to create ~p nodes ~n", [self(),Nodes-1]),
    loop(NextNode).

loop(NextNode) ->
    receive
        {FirstNode, 0, _} when FirstNode =:= self() ->
            io:format("I am the first node no more loop done here"),
            true;
        {FirstNode, 0, Mex} ->
            io:format("I am NOT the first ~p send and I have done ~n", [self()]),
            NextNode ! {FirstNode, 0, Mex},
            true;
        {FirstNode, Laps, Mex} when FirstNode =:= self() ->
            io:format("I am ~p the first, decrease lap and send to ~p~n", [self(),NextNode]),
            NextNode! {FirstNode, Laps-1, Mex},
            loop(NextNode);
        {FirstNode, Laps, Mex} ->
            io:format("I am ~p Get a message, send to my next ~p~n", [self(),NextNode]),
            NextNode! {FirstNode, Laps, Mex},
            loop(NextNode)
    end.

