-module(utils).
-export([create_http_handler/3, return_json/2, return_json/3]).

return_json(Req, Body) -> 
    return_json(Req, Body, 200).
return_json(Req, Body, Status) ->
    {ok, Req_} = cowboy_req:reply(Status, [{<<"content-type">>, <<"application/json">>}], Body, Req),
    {ok, Req_, #{}}.

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