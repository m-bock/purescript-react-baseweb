SHELL=/usr/bin/env bash

default: check-format test build

install:
	yarn install
	spago install

clean:
	rm -rf dist output node_modules

format:
	shopt -s globstar; nixfmt **/*.nix
	shopt -s globstar; purty-format **/*.purs
	shopt -s globstar; dhall-format **/*.dhall

check-format:
	shopt -s globstar; nixfmt --check **/*.nix
	shopt -s globstar; purty-check **/*.purs
	shopt -s globstar; dhall-check **/*.dhall

build:
	psa '.spago/*/*/src/**/*.purs' 'src/**/*.purs' 'test/**/*.purs' 'example/**/*.purs' --is-lib=.spago --strict --stash --censor-lib
	parcel build --public-url "." example/simple.html
	
test:
	node -e "require('./output/Test/Main/index.js').main()"

nix-generate:
	spago2nix generate
