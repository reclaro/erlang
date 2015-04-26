-module(geometry).
-export([test/0, area/1, filter/2]).

test() ->
    12 = area({rectangle, 3, 4}),
    9 = area({square, 3}),
    test_worked.

area({rectangle, Width, Height}) -> Width * Height ;
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius.

filter(F,L) ->
    [X || X <- L, F(X) =:= true].

%-record(Name, {
%          key1 = 4,
%          key3 }).
-record(person, {name, phone, address}).
