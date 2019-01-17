-module(blinds_manager).

-export([init/1]).

init(Blinds) ->
    ets:new(blinds_table, [set, named_table]),
    ets:insert(blinds_table, {blinds, Blinds}),
    io:write(Blinds),
    listen().

listen() ->
    io:fwrite("blinds manager listening"),
    receive
        {open_blind, Index, ok} -> open_blind(Index), listen();
        {close_blind, Index, ok} -> close_blind(Index), listen();
        {open_all, ok} -> io:fwrite("open all"), open_all(), listen();
        {close_all, ok} -> io:fwrite("close all"), close_all(), listen();
        Other -> io:write(Other)
    end.

open_blind(Index) -> 
    io:fwrite("open blind with Index"),
    [{blinds, Blinds}] = ets:lookup(blinds_table, blinds),
    Pid = lists:nth(Index, Blinds),
    Pid ! {open, ok}.

open_all() -> 
    io:fwrite("open All blinds"),
    [{blinds, Blinds}] = ets:lookup(blinds_table, blinds),
    lists:foreach(fun (Blind) -> Blind ! {open, ok} end, Blinds).

close_blind(Index) ->
    io:fwrite("close blind with Index"),
    [{blinds, Blinds}] = ets:lookup(blinds_table, blinds),
    Pid = lists:nth(Index, Blinds),
    Pid ! {open, ok}.

close_all() ->
    io:fwrite("close All blinds"),
    [{blinds, Blinds}] = ets:lookup(blinds_table, blinds),
    lists:foreach(fun (Blind) -> Blind ! {close, ok} end, Blinds).