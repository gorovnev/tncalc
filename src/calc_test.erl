-module( calc_test ).
-include_lib( "eunit/include/eunit.hrl" ).

parse_calc( Data ) ->
    {ok, Result} = calc:parse( Data ),
    calc:calculate( Result ).

calc_test_() ->
    [
        ?_assertEqual(    3, parse_calc( " 1 + 2" ) ),
        ?_assertEqual(   15, parse_calc( "1+2*(3+4)" ) ),
        ?_assertEqual(   14, parse_calc( "(3+4)*2" ) ),
        ?_assertEqual(   11, parse_calc( " 3 + 4 * 2 " ) ),
        ?_assertEqual(   14, parse_calc( "3*4+2" ) ),
        ?_assertEqual(   10, parse_calc( "3*4-2" ) ),
        ?_assertEqual( 15.0, parse_calc( "3*(4+2*(2+1))/2" ) ),
        ?_assertEqual(  6.0, parse_calc( "3*4/2" ) )
    ].

