-module(http_listener).
-export([init/2]).

init(Alarm, Manager) -> 
    Paths = [
        {"/open/:blindIndex", open_blind_handler, {manager, Manager}},
        {"/close/:blindIndex", close_blind_handler, {manager, Manager}},
        {"/closeAll/", close_all_handler, {manager, Manager}},
        {"/openAll/", open_all_handler, {manager, Manager}},
        {"/alarm/", alarm_invoke_handler, {alarm, Alarm}},
        {"/defuse/", defuse_handler, {alarm, Alarm}}
    ],
     Dispatch = cowboy_router:compile([
        {'_', Paths}
    ]),
    cowboy:start_http(
        app_http,
        100, 
        [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}, {middlewares, [cowboy_router, middleware_cors, cowboy_handler]}]
).

