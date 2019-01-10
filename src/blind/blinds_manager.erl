-module(blinds_manager).

-export([init/1]).

init(Blinds) ->
    ets:new(blinds_manager, [set, named_table]),
    ets:insert(blinds_manager, {blinds, Blinds}),
    listen().

listen() -> 
    receive
        {open_blind, Index, ok} -> open_blind(Index), listen();
        {close_blind, Index, ok} -> close_blind(Index), listen();
        {open_all, ok} -> open_all(), listen();
        {close_all, ok} -> close_all(), listen()
    end.

open_blind(Index) -> 
    io:format("open blind with Index"),
    [{blinds, Blinds}] = ets:lookup(blinds_manager, blinds),
    Pid = lists:nth(Index, Blinds),
    Pid ! {open, ok}.

open_all() -> 
    io:format("open All blinds"),
    [{blinds, Blinds}] = ets:lookup(blinds_manager, blinds),
    lists:foreach(open_blind, Blinds).

close_blind(Index) ->
    io:format("close blind with Index"),
    [{blinds, Blinds}] = ets:lookup(blinds_manager, blinds),
    Pid = lists:nth(Index, Blinds),
    Pid ! {open, ok}.

close_all() ->
    io:format("close All blinds"),
    [{blinds, Blinds}] = ets:lookup(blinds_manager, blinds),
    lists:foreach(close_blind, Blinds).

