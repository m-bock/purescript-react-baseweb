SHELL=/usr/bin/env bash -O globstar -O extglob

default: check-format build check-test

install:
	yarn install
	spago install

clean:
	rm -rf dist output node_modules

format-nix:
	for src in `git ls-files '*.nix'` ; do \
		nixfmt $$src; \
	done \

format-purs:
	for src in `git ls-files '*.purs'` ; do \
		purty $$src --write; \
	done \

format-dhall:
	for src in `git ls-files '*.dhall'` ; do \
		dhall format --inplace $$src; \
	done \

check-format-nix:
	for src in `git ls-files '*.nix'` ; do \
		nixfmt --check $$src; \
	done \

check-format-purs:
	for src in `git ls-files '*.purs'` ; do \
		ACTUAL="`cat $$src`" ; \
		EXPECTED="`purty $$src`" ; \
		if test "$$ACTUAL" != "$$EXPECTED" ; then \
			echo "$$src not formatted." ; \
			exit 1 ; \
		fi \
	done \

check-format-dhall:
	for src in `git ls-files '*.dhall'` ; do \
		cat $$src | dhall format --check ; \
	done \

format: format-nix format-purs format-dhall

check-format: check-format-nix check-format-purs check-format-dhall

build-purescript:
	psa \
		@(src|test|example)/**/*.purs \
		.spago/*/*/src/**/*.purs \
		--is-lib=.spago \
		--strict \
		--stash \
		--censor-lib \

build-parcel:
	parcel build --public-url "." example/simple.html

build: build-purescript build-parcel
	
check-test:
	node -e "require('./output/Test.Main').main()"

check: check-format check-test

nix-generate:
	spago2nix generate
