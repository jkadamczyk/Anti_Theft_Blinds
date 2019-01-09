-module(start_handler).

-behaviour(cowboy_http_handler).

-export([init/3]).

-export([handle/2]).

-export([terminate/3]).

-record(state, {}).

init(_, Req, _Opts) -> {ok, Req, #state{}}.

handle(Req, State = #state{}) ->
    Erlang="Erlang",
    utils:return_json(Req, jiffy:encode({[{hello, list_to_binary(Erlang)}]})).

terminate(_Reason, _Req, _State) -> ok.
