-module(blind).
-export([init/0]).

% This file hold single gate process logic

get_name() -> list_to_atom("gate" ++ pid_to_list(self())).

init() ->
  ets:new(get_name(), [set, named_table]),
  ets:insert(get_name(), [{open, true}]),
  timer:send_interval(200, self(), {move, ok}),
  listen().

listen() ->
  receive
    {open, ok} -> set_state(true), listen();
    {close, ok} -> set_state(false), listen();
    {status, Pid, ok} -> Pid ! {open, get_state(), ok}, listen()
  end.

get_state() ->
    [{open, State}] = ets:lookup(get_name(), open),
    State.

set_state(State) ->
  ets:insert(get_name(), {open, State}).