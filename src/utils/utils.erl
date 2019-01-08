-module(utils).

-export([create_http_handler/3]).

create_http_handler(Paths, Port, Name) ->
    Dispatch = cowboy_router:compile([
        {'_', Paths}
    ]),
    cowboy:start_http(
        Name,
        100, 
        [{port, Port}],
        [{env, [{dispatch, Dispatch}]}]
).