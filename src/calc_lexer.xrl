%% Lexer for calculator

Definitions.

%% Digits
D   = [0-9]
%% Operations
Op  = (\*|\+|-|\/)

Rules.

{D}+    :   { token, {digit, TokenLine, list_to_integer(TokenChars)} }.
%{D}+    :   { token, list_to_integer(TokenChars) }.

%{Op}     :   { token, {operation, TokenLine, list_to_atom( TokenChars ) } }.
{Op}     :   { token, list_to_atom( TokenChars) }.
%[()]     :   { token, list_to_atom( TokenChars ), TokenLine }.
%(\(|\))     :   { token, list_to_atom( TokenChars ), TokenLine }.
[()]   :   { token, {list_to_atom( TokenChars ), TokenLine} }.
%[\(\)]   :   { token, TokenChars }.
.		: 	{ token, {unknown_token, TokenLine, TokenChars} }.

Erlang code.

