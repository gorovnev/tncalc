-module(calc_protocol).
-export([start_link/4, init/4]).

start_link(Ref, Socket, Transport, Opts) ->
    Pid = spawn_link(?MODULE, init, [Ref, Socket, Transport, Opts]),
    {ok, Pid}.

init(Ref, Socket, Transport, _Opts = []) ->
    ok = ranch:accept_ack(Ref),
    Welcome = "TelNet Calculator welcomes you! When work is done type 'quit' to exit.\n",
    Transport:send(Socket, Welcome),
    loop(Socket, Transport).

loop(Socket, Transport) ->
    case Transport:recv(Socket, 0, 60000) of
        {ok, <<"quit", _Rest/binary>>} ->
            Transport:send(Socket, "Bye!\n"),
            lager:info( "The work is done. Close connection." ),
            ok = Transport:close(Socket);
        {ok, BinData} ->
            Data = binary_to_list( BinData ),
            lager:info( "Got data:~p", [Data] ),
            Resp = case calc:parse( Data ) of
                {ok, ParseTree} ->
                    calc:calculate( ParseTree );
                {error, Err} ->
                    lager:error( "Input error~p", [Err] ),
                    "input error"
            end,
            lager:info( "Calc result:~p", [Resp] ),
            Transport:send(Socket, io_lib:format("~p~n", [Resp])),
            loop(Socket, Transport);
        _ ->
            ok = Transport:close(Socket)
    end.

