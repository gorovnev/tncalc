-module( calc ).
-export( [test/0, parse/1, calculate/1] ).

test() ->
    ok.

parse( String ) ->
    {ok, Tokens, _EndLine} = calc_lexer:string( String ),
    calc_parser:parse( Tokens ).

calculate( Number ) when is_integer(Number);is_float(Number) -> Number;
calculate( {{Op}, Var1, Var2} ) ->
    case Op of
        '+' -> calculate(Var1) + calculate(Var2);
        '*' -> calculate(Var1) * calculate(Var2);
        '-' -> calculate(Var1) - calculate(Var2);
        '/' -> calculate(Var1) / calculate(Var2)
    end.

