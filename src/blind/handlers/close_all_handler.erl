-module(close_all_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {manager}).

init(_, Req, _Opts={manager, Manager}) ->
	Manager ! {close_all, ok},
	{ok, Req, #state{manager = Manager}}.

handle(Req, State=#state{manager = Manager}) ->
    Body = jiffy:encode({[{blindsStatus, [false, false, false, false, false, false]}]}),
    {ok, Req1} = cowboy_req:reply(
		200,
		[{<<"content-type">>,<<"application/json">>}],
		Body,
		Req
	),
    {ok, Req1, State}.

terminate(_Reason, _Req, _State) ->
	ok.
