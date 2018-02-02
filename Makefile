MIX = mix
.DEFAULT_GOAL	:= all

.PHONY: all compile clean-all clean clobber test check deps rel shell xref dialyzer eunit shell

all: compile

compile: deps
	@$(MIX) compile

deps:
	@$(MIX) deps

clean-all: clean

clean:
	@$(MIX) clean
	rm -rf apps/*/cover

clobber: clean
	rm -rf _build

check: xref dialyzer unit ;

dialyzer:
	@$(MIX) dialyzer

unit:
	@$(MIX) test --cover

xref:
	@$(MIX) xref graph

shell: compile
	iex -S $(MIX)
