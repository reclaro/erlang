% To test it using the shell, run it:
% c(monitoring).
% Tokill = monitoring:spawnLoop().
% exit(Tokill,"Your reason").
-module(monitoring).
-export([start/0, spawnLoop/0, killMyself/0, createMonitor/1]).



spawnLoop() ->
    Tomonitor = spawn(monitoring, start, []),
    io:format("PID to monitor ~p~n", [Tomonitor]),
    register(looper, Tomonitor),
    ControllerPid = spawn(monitoring, createMonitor, [Tomonitor]),
    Tomonitor.

killMyself() ->
    exit("I am exiting").


createMonitor(Tomonitor) ->
    io:format("I am in createMonitor~n"),
    Ref = erlang:monitor(process, Tomonitor),
    io:format("Hi I am ~p and I am monitoring ~p with the process ~p~n",
              [self(), Tomonitor, Ref]),
    receive {'DOWN', Ref, process,Tomonitor, Why} ->
                io:format("The process pid ~p died, because of ~p~n",
                          [Tomonitor,Why]),
                Newmonitor = spawn(monitoring, start, []),
                createMonitor(Newmonitor)
    end.

start(Secsleep) ->
    io:format("I am still alive~n"),
    timer:sleep(Secsleep),
    start(Secsleep).

start() ->
    io:format("I am still alive and I am ~p~n", [self()]),
    timer:sleep(2000),
    start().
