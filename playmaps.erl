-module(playmaps).
-export([count_char/1]).

count_char(Str) ->
    count_char(Str, #{}).

count_char([H|T], #{}=X) ->
     io:format("CIAO"),
     X;
count_char([H|T], X) ->
    X;
count_char([], X) -> X.


