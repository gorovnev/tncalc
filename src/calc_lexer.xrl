%% Lexer for calculator

Definitions.

%% Digits
D   = [0-9]
%% Operations
Op  = (\*|\+|-|\/)

Rules.

{D}+       :   { token, {digit, TokenLine, list_to_integer(TokenChars)} }.
{D}+\.{D}+ :   { token, {digit, TokenLine, list_to_float(TokenChars)} }.

{Op}       :   { token, {list_to_atom( TokenChars)} }.
[()]       :   { token, {list_to_atom( TokenChars ), TokenLine} }.
\n		   : 	skip_token.
.		   : 	skip_token.

Erlang code.

