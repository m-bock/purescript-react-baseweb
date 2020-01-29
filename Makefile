SHELL=/usr/bin/env bash

format:
	shopt -s globstar; nixfmt **/*.nix
	shopt -s globstar; purty-format src/**/*.purs test/**/*.purs

check:
	shopt -s globstar; nixfmt --check **/*.nix
	shopt -s globstar; purty-check src/**/*.purs test/**/*.purs
	spago test --purs-args "--stash --strict"