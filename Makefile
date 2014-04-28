ERL=erl -I -pa ebin -noshell -eval
SOURCE_DIR=src
CALC_NAME=calc
RELX=deps/relx/relx
LEXER_NAME=$(CALC_NAME)_lexer
PARSER_NAME=$(CALC_NAME)_parser
SOURCES=$(wildcard $(SOURCE_DIR)/*.erl)

default: generate compile

#$(SOURCE_DIR)/$(LEXER_NAME).erl : $(SOURCE_DIR)/$(LEXER_NAME).xrl
generate:
	$(ERL) 'leex:file("$(SOURCE_DIR)/$(LEXER_NAME)"), halt().'
	$(ERL) 'yecc:file("$(SOURCE_DIR)/$(PARSER_NAME)"), halt().'

init:
	rebar get-deps

test:
	make generate
	rebar eunit

compile: $(SOURCE_DIR)/*.erl
	rebar compile

clean:
	rebar clean
	rm -rf ./_rel

relx:
	cd deps/relx && make && cd ../..

rel: 
	$(RELX)

run:
	_rel/bin/tncalc

