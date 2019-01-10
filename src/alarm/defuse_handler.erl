-module(defuse_handler).

-behaviour(cowboy_http_handler).

-export([init/3]).

-export([handle/2]).

-export([terminate/3]).

-record(state, {alarm}).

init(_, Req, _Opts = {alarm, Alarm}) ->
    {ok, Req, #state{alarm = Alarm}}.

handle(Req, State = #state{alarm = Alarm}) ->
    Alarm ! {defuse, ok},
    Body = jiffy:encode({[
		{isAlarmOn, false},
		{blindsStatus, [true, true, true, true, true, true]}
	]}),
    {ok, Req1} = cowboy_req:reply(
		200,
		[{<<"content-type">>,<<"application/json">>}],
		Body, 
		Req
	),
    {ok, Req1, State}.

terminate(_Reason, _Req, _State) -> ok.
