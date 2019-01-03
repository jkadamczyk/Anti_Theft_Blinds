-module(pwirProj_root).

-export([init/2]).

init(Req0, Opts) ->
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain">>
	}, <<"O nie! ALARM! OPUSZCZAĆ ROLETY!">>, Req0),
	{ok, Req, Opts}.