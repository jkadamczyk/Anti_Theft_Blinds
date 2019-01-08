-module(http_listener).
-export([init/0]).

init() -> 
    Paths = [
        {"/", start_handler, []},
        {"/open/:blindIndex", open_blind_handler, []},
        {"/close/:blindIndex", close_blind_handler, []},
        {"/closeAll/", close_all_handler, []},
        {"/openAll/", open_all_handler, []},
        {"/alarm/", alarm_invoke_handler, []},
        {"/defuse/", defuse_handler, []}
    ],
    utils:create_http_handler(Paths, 8000, app_listener).

