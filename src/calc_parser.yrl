Nonterminals
predicates predicate group element.

Terminals '(' ')' '+' '*'
digit.% operation.

Rootsymbol predicates.

%Left 300 '+'.
%Left 400 '*'.

predicates -> predicate : '$1'.
%predicate -> predicate operation predicate : {unwrap('$2'), '$1', '$3'}.
predicate -> predicate '+' predicate : {'$2', '$1', '$3'}.
predicate -> predicate '*' predicate : {'$2', '$1', '$3'}.
predicate -> '(' group ')' : {'$2'}.
predicate -> group : '$1'.
group -> element : '$1'.
%group -> element operation predicate : {unwrap('$2'), '$1', '$3'}.
group -> element '+' predicate : {'$2', '$1', '$3'}.
group -> element '*' predicate : {'$2', '$1', '$3'}.
element -> digit : unwrap( '$1' ).

Erlang code.

unwrap({_,_,Token}) -> Token.

dbg_print( Line ) ->
    io:format( "Line:~p~n", [Line] ).

operate( Digit1, Op, Digit2 ) ->
    io:format( "~p ~p ~p~n", [Digit1, Op, Digit2] ),
    case Op of
        '+' -> Digit1 + Digit2;
        '-' -> Digit1 - Digit2;
        '*' -> Digit1 * Digit2;
        '/' -> Digit1 / Digit2
    end.

