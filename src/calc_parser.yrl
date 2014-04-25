Nonterminals
predicate.

Terminals '(' ')' '+' '*' '-' '/'
digit.

Rootsymbol predicate.

Left 100 '-'.
Left 200 '+'.
Left 300 '*'.
Left 400 '/'.

predicate -> predicate '+' predicate : {'$2', '$1', '$3'}.
predicate -> predicate '*' predicate : {'$2', '$1', '$3'}.
predicate -> predicate '-' predicate : {'$2', '$1', '$3'}.
predicate -> predicate '/' predicate : {'$2', '$1', '$3'}.
predicate -> '(' predicate ')' : '$2'.
predicate -> digit : unwrap( '$1' ).

Erlang code.

unwrap({_,_,Token}) -> Token.

