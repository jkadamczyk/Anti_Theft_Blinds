-module(blind).

-export([init/0]).

% This file hold single gate process logic

get_name() ->
    list_to_atom("gate" ++ pid_to_list(self())).

init() ->
    ets:new(get_name(), [named_table, set]),
    ets:insert(get_name(), [{state, false}]),
    listen().

listen() ->
    receive
      {open, ok} -> set_state(false), listen();
      {close, ok} -> set_state(true), listen();
      {status, Pid, ok} ->
	  Pid ! {state, get_state(), ok}, listen()
    end.

get_state() ->
    io:fwrite("get state of blind"),
    [{state, State}] = ets:lookup(get_name(), state),
    State.

set_state(State) ->
    io:fwrite("set state of blind"),
    ets:insert(get_name(), {state, State}).
