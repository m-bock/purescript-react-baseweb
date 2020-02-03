SHELL=/usr/bin/env bash -O globstar -O extglob

psa := psa \
		.spago/*/*/src/**/*.purs \
		--is-lib=.spago \
		--strict \
		--stash \
		--censor-lib

default: check-format build check-test

install:
	yarn install
	spago install

clean:
	rm -rf dist output node_modules

format-nix:
	for src in `git ls-files '*.nix'` ; do \
		nixfmt $$src; \
	done

format-purs:
	for src in `git ls-files '*.purs'` ; do \
		purty $$src --write; \
	done

format-dhall:
	for src in `git ls-files '*.dhall'` ; do \
		dhall format --inplace $$src; \
	done

check-format-nix:
	for src in `git ls-files '*.nix'` ; do \
		nixfmt --check $$src; \
	done

check-format-purs:
	for src in `git ls-files '*.purs'` ; do \
		ACTUAL="`cat $$src`" ; \
		EXPECTED="`purty $$src`" ; \
		if test "$$ACTUAL" != "$$EXPECTED" ; then \
			echo "$$src not formatted." ; \
			exit 1 ; \
		fi \
	done

check-format-dhall:
	for src in `git ls-files '*.dhall'` ; do \
		cat $$src | dhall format --check ; \
	done

format: format-nix format-purs format-dhall

check-format: check-format-nix check-format-purs check-format-dhall

build-src:
	$(psa) src/**/*.purs

build-example:
	$(psa) @(src|example)/**/*.purs \
	parcel build --public-url "." example/simple.html

build-test:
	$(psa) @(test|src)/**/*.purs

build: build-src build-example build-test
	
check-test:
	node -e "require('./output/Test.Main').main()"

check: check-format check-test

nix-generate:
	cd src; spago2nix generate
	cd test; spago2nix generate
	cd example; spago2nix generate
