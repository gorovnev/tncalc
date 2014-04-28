ERL=erl -I -pa ebin -noshell -eval
SOURCE_DIR=src
CALC_NAME=calc
LEXER_NAME=$(CALC_NAME)_lexer
PARSER_NAME=$(CALC_NAME)_parser
SOURCES=$(wildcard $(SOURCE_DIR)/*.erl)

default: generate compile

#$(SOURCE_DIR)/$(LEXER_NAME).erl : $(SOURCE_DIR)/$(LEXER_NAME).xrl
generate:
	$(ERL) 'leex:file("$(SOURCE_DIR)/$(LEXER_NAME)"), halt().'
	$(ERL) 'yecc:file("$(SOURCE_DIR)/$(PARSER_NAME)"), halt().'

test:
	rebar eunit

compile: $(SOURCE_DIR)/*.erl
	rebar compile

clean:
	rebar clean
	rm -rf ./_rel
rel:
	deps/relx/relx

run:
	_rel/bin/tncalc

