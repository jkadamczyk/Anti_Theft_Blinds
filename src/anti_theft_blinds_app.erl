-module(anti_theft_blinds_app).

-behaviour(application).

-export([start/2]).

-export([stop/1]).

start(_Type, _Args) ->
    http_listener:init(),
    anti_theft_blinds_sup:start_link().

stop(_State) -> ok.
