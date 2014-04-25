-module( calc ).
-export( [test/0, parse/1] ).

test() ->
    ok.

parse( String ) ->
    {ok, Tokens, EndLine} = calc_lexer:string( String ),
    io:format( "Tokens:~p~n", [Tokens] ),
    {ok, ParseTree} = calc_parser:parse( Tokens ),
    ParseTree.
