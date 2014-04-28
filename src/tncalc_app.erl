-module(tncalc_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, _} = ranch:start_listener(calc_echo, 1,
        ranch_tcp, [{port, 5555}], calc_protocol, []),
    tncalc_sup:start_link().

stop(_State) ->
    ok.
