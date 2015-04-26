-module(invbinary).
-export([roz_binary_to_list/1, inverse_binary/1, rev/2]).

roz_binary_to_list(L) ->
    case is_binary(L) of
        true -> [ X || <<X:8>> <= L];
        false -> {false,io:format("It is not a binary")}
    end.

inverse_binary(L) ->
    case roz_binary_to_list(L) of
       [H|T] -> Rev = lists:reverse(roz_binary_to_list(L)),
                << <<X>> || X <- Rev>>;
       {false, Error} -> Error
    end.

rev(<<>>, Acc) -> Acc;
rev(<<H:1/binary, Tail/binary>>, Acc)->
    rev(Tail, <<H/binary, Acc/binary>>).
