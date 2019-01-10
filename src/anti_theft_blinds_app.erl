-module(anti_theft_blinds_app).

-behaviour(application).

-export([start/2]).

-export([stop/1]).

start(_Type, _Args) ->
    N = 6,
    Blinds = lists:map(
        fun (_) -> secure_spawn(blind, init, []) end,
        lists:seq(1,N)
    ),
    Manager = secure_spawn(blinds_manager, init, [Blinds]),
    Alarm = secure_spawn(alarm, init, [Manager]),
    http_listener:init(Alarm, Manager),
    anti_theft_blinds_sup:start_link().

stop(_State) -> ok.


secure_spawn(Name, Fun, Args) ->
    try spawn(Name, Fun, Args) of
        Val -> Val
    catch
        Exception:Reason -> 
            io:fwrite("Exception ~w", [Reason])
    end.
