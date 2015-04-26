-module(lib_misc).
-export([for/3, perms/1, roz/2, steps/1, splitter/1, odds_and_evens/1]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I+1, Max, F)].

splitter([]) -> [];
splitter(L) ->
    Even = [X || X <- L, (X rem 2) =:= 0 ],
    Odd = [X || X <- L, (X rem 2) =:= 1 ],
    {Even, Odd}.

odds_and_evens(L) ->
    odds_and_evens_acc(L,[], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;

odds_and_evens_acc([], Odds, Evens) ->
    {Odds, Evens}.


roz([]) -> [[]]; %,  io:format("Vuoto");
roz(L) -> [L]. %, io:format("Non Vuoto ~n~p~n", [L]).
roz(L,T) -> [L|T]. %,io:format("Testa eco ~n~p~n~p", [L,T]).

steps(L) -> [roz(H,T) || H <- L, T <- L -- [H]].
%steps(L) -> [roz(H,T) || H <- L, T <- L -- [H]].
%
perms([]) -> [[]];
perms(L) ->[[H|T] || H <- L, T <- perms(L --[H])].
