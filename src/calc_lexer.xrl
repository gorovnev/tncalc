%% Lexer for calculator

Definitions.

%% Digits
D   = [0-9]
%% Operations
Op  = (\*|\+|-|\/)

Rules.

{D}+    :   { token, {digit, TokenLine, list_to_integer(TokenChars)} }.

{Op}     :   { token, {list_to_atom( TokenChars)} }.
[()]   :   { token, {list_to_atom( TokenChars ), TokenLine} }.
.		: 	skip_token.

Erlang code.

