.PHONY: build install uninstall doc clean

build:
	dune build @install

install:
	dune install

uninstall:
	dune uninstall

doc:
	dune build @doc

clean:
	dune clean
