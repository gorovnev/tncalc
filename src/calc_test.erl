-module( calc_test ).
-include_lib( "eunit/include/eunit.hrl" ).

parse_func( Data ) ->
    Result = calc:parse( Data ),
    ?debugFmt( "Data:~s result:~p~n", [Data, Result] ),
    ok.

parse_test_() ->
    Data1 = "1+2",
    %Data2 = "1+2*(3+4)",
    %Data3 = "(3+4)*2",
    %Data4 = "3+4*2",
    Data5 = "3*4+2",
    [
        ?_assertEqual( ok, parse_func( Data1 ) ),
        %?_assertEqual( ok, parse_func( Data2 ) ),
        %?_assertEqual( ok, parse_func( Data3 ) ),
        %?_assertEqual( ok, parse_func( Data4 ) ),
        ?_assertEqual( ok, parse_func( Data5 ) )
    ].

