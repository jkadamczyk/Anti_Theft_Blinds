-module(open_all_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {
}).

init(_, Req, _Opts) ->
	{ok, Req, #state{}}.

handle(Req, State=#state{}) ->
	utils:return_json(Req, "{\"hello\": \"erlang\"}").

terminate(_Reason, _Req, _State) ->
	ok.
