.PHONY: build install uninstall clean

build:
	dune build @install

install:
	dune install

uninstall:
	dune uninstall

clean:
	dune clean