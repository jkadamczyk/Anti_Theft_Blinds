-module(anti_theft_blinds_app).

-behaviour(application).

-export([start/2]).

-export([stop/1]).

start(_Type, _Args) ->
    % Initialize processes here and collect their PIDs
    % Pass them to http_listener
    N = 6,
    Blinds = [lists:map(
        fun (_) -> spawn(blind, init, []) end,
        lists:seq(1,N)
    )],
    Manager = spawn(blinds_manager, init, [Blinds]),
    Alarm = spawn(alarm, init, [Manager]),
    http_listener:init(Manager, Alarm),
    anti_theft_blinds_sup:start_link().

stop(_State) -> ok.
