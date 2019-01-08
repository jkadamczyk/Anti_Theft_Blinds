-module(anti_theft_blinds_app).

-behaviour(application).

-export([start/2]).

-export([stop/1]).

start(_Type, _Args) ->
   Dispatch = cowboy_router:compile([
        {'_', [{"/", anti_theft_blinds_root, []}]}
    ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8082}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    anti_theft_blinds_sup:start_link().

stop(_State) -> ok.
