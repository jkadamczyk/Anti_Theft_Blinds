-module(alarm).

-export([init/1]).

init(Manager) ->
    ets:new(alarm, [set, named_table]),
    ets:insert(alarm, [{armed, false}]),
    ets:insert(alarm, [{manager, Manager}]),
    listen().

listen() ->
    receive
      {arm, ok} -> arm(), listen();
      {defuse, ok} -> defuse(), listen();
      {status, Pid, ok} ->
	  Pid ! {open, get_state(), ok}, listen()
    end.

get_state() ->
    io:format("state taken"),
    [{armed, State}] = ets:lookup(alarm, armed), State.

arm() ->
    io:format("alarm armed"),
    [{manager, Manager}] = ets:lookup(alarm, manager),
    Manager ! {close_all, ok},
    ets:insert(alarm, {armed, true}).

defuse() ->
    io:format("alarm defused"),
    [{manager, Manager}] = ets:lookup(alarm, manager),
    Manager ! {open_all, ok},
    ets:insert(alarm, {armed, false}).
