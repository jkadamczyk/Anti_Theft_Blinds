-module(alarm).

-export([init/1]).

init(Manager) ->
    ets:new(table, [named_table, set]),
    ets:insert(table, [{armed, false}]),
    ets:insert(table, [{manager, Manager}]),
    listen().

listen() ->
    io:fwrite("alarm listening"),
    receive  
      {arm, ok} -> arm(), listen();
      {defuse, ok} -> defuse(), listen();
      {status, Pid, ok} ->
	    Pid ! {open, get_state(), ok}, listen();
      _Other -> io:fwrite("Got a message ya know")  
    end.

get_state() ->
    io:fwrite("state taken"),
    [{armed, State}] = ets:lookup(table, armed),
    State.

arm() ->
    io:fwrite("alarm armed"),
    [{manager, Manager}] = ets:lookup(table, manager),
    Manager ! {close_all, ok},
    ets:insert(table, {armed, true}).

defuse() ->
    io:fwrite("alarm defused"),
    ets:insert(table, {armed, false}).
