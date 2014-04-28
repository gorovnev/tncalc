-module( calc ).
-export( [test/0, parse/1, calculate/1] ).

test() ->
    ok.

parse( String ) ->
    {ok, Tokens, _EndLine} = calc_lexer:string( String ),
    calc_parser:parse( Tokens ).

make_calculation( Number ) when is_integer(Number);is_float(Number) -> Number;
make_calculation( {{Op}, Var1, Var2} ) ->
    case Op of
        '+' -> make_calculation(Var1) + make_calculation(Var2);
        '*' -> make_calculation(Var1) * make_calculation(Var2);
        '-' -> make_calculation(Var1) - make_calculation(Var2);
        '/' -> make_calculation(Var1) / make_calculation(Var2)
    end.

calculate( ParseTree ) ->
    try make_calculation( ParseTree ) of
        Num -> {ok, Num}
    catch
        ErrType:Err ->
            lager:error( "Error type:~p, error:~p", [ErrType, Err] ),
            {error, Err}
    end.
