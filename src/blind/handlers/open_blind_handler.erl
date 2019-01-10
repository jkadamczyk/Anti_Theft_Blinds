-module(open_blind_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {manager}).

init(_, Req, _Opts = {manager, Manager}) ->
	{ok, Req, #state{manager = Manager}}.

handle(Req, State = #state{manager = Manager}) ->
	{Index, Req1} = cowboy_req:binding(blindIndex, Req),
	Manager ! {open_blind, (list_to_integer(binary_to_list(Index)) + 1),  ok},
	Body = jiffy:encode({[
		{blindIndex, Index},
		{isOpen, true}]}),
	{ok, Req2} = cowboy_req:reply(
		200, 
		[{<<"content-type">>, <<"application/json">>}], 
		Body, 
		Req1
	),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.

