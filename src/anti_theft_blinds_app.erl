-module(anti_theft_blinds_app).

-behaviour(application).

-export([start/2]).

-export([stop/1]).

start(_Type, _Args) ->
    utils:create_http_handler([{"/", anti_theft_blinds_root, []}], 8082, hello_world),
    anti_theft_blinds_sup:start_link().

stop(_State) -> ok.
