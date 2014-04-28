-module( calc_test ).
-include_lib( "eunit/include/eunit.hrl" ).

parse_calc( Data ) ->
    {ok, Result} = calc:parse( Data ),
    calc:calculate( Result ).

calc_test_() ->
    [
        ?_assertEqual({ok,    3}, parse_calc( " 1 + 2" ) ),
        ?_assertEqual({ok,   15}, parse_calc( "1+2*(3+4)" ) ),
        ?_assertEqual({ok,   14}, parse_calc( "(3+4)*2" ) ),
        ?_assertEqual({ok,   11}, parse_calc( " 3 + 4 * 2 " ) ),
        ?_assertEqual({ok,   14}, parse_calc( "3*4+2" ) ),
        ?_assertEqual({ok,   10}, parse_calc( "3*4-2" ) ),
        ?_assertEqual({ok,   11}, parse_calc( "3*4-1\n" ) ),
        ?_assertEqual({ok, 10.0}, parse_calc( "3.0*4.0-2.0" ) ),
        ?_assertEqual({ok, 15.0}, parse_calc( "3*(4+2*(2+1))/2" ) ),
        ?_assertEqual({ok,  6.0}, parse_calc( "3*4/2" ) ),
        ?_assertEqual({error, badarith}, parse_calc( "1/0" ) )
    ].

