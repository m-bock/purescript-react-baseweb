SHELL=/usr/bin/env bash

build-example:
	spago --config example/spago.dhall build
	parcel build --public-url "." example/simple.html

format:
	shopt -s globstar; nixfmt **/*.nix
	shopt -s globstar; purty-format **/*.purs

check:
	shopt -s globstar; nixfmt --check **/*.nix
	shopt -s globstar; purty-check **/*.purs
	spago --config test/spago.dhall test --purs-args "--stash --strict"

ci: check build-example