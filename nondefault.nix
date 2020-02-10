{ pkgs, runCommand, mkDerivation, nixfmt, spago, writeShellScriptBin, purs
, yarn2nix, yarn, spago2nix, fetchgit, make, bash, nix-gitignore, dhall, git
, nodejs, purty }:

let
  packageJsonMeta = {
    pname = "purescript-baseweb-dev";
    name = "purescript-baseweb-dev";
    version = "1.0.0";
    packageJSON = ./package.json;
    yarnLock = ./yarn.lock;
  };

  yarnPackage = yarn2nix.mkYarnPackage (packageJsonMeta // {
    src = runCommand "src" { } ''
      mkdir $out
      ln -s ${./package.json} $out/package.json
      ln -s ${./yarn.lock} $out/yarn.lock
    '';
    publishBinsFor = [ "purescript-psa" "parcel" "prettier" ];
  });

  yarnModules = yarn2nix.mkYarnModules packageJsonMeta;

  cleanSrc = runCommand "src" { } ''
    mkdir $out
    cp -r ${nix-gitignore.gitignoreSource [ ] ./.}/* -t $out
    cd $out
    ${git}/bin/git init
    ${git}/bin/git add --all
    ln -s ${yarnModules}/node_modules $out/node_modules
  '';

  make' = writeShellScriptBin "make" ''
    ${make}/bin/make SHELL="${bash}/bin/bash -O globstar -O extglob" $@
  '';

  buildSrc = mkDerivation {
    name = "src";
    buildInputs = [ yarnPackage purs make' ];
    buildCommand = ''
      TMP=`mktemp -d`
      cd $TMP

      cp -r ${pkgs.lib.sourceByRegex ./. [ "^(Makefile|src)$" ]}/* .

      bash ${(pkgs.callPackage ./src/spago-packages.nix { }).installSpagoStyle}
      make build-src

      ln -s output $out   
    '';
  };

  buildTest = mkDerivation {
    name = "test";
    buildInputs = [ yarnPackage purs make' nodejs ];
    buildCommand = ''
      TMP=`mktemp -d`
      cd $TMP

      cp -r ${pkgs.lib.sourceByRegex ./. [ "^(Makefile|src|test)$" ]}/* .
      ln -s ${yarnModules}/node_modules node_modules

      bash ${(pkgs.callPackage ./test/spago-packages.nix { }).installSpagoStyle}
      make build-test
      make check-test

      ln -s output $out   
    '';
  };

  buildExample = mkDerivation {
    name = "example";
    buildInputs = [ yarnPackage purs make' ];
    buildCommand = ''
      TMP=`mktemp -d`
      cd $TMP

      cp -r ${pkgs.lib.sourceByRegex ./. [ "^(Makefile|src|example)$" ]}/* .
      ln -s ${yarnModules}/node_modules node_modules

      bash ${
        (pkgs.callPackage ./example/spago-packages.nix { }).installSpagoStyle
      }
      make build-example

      ln -s dist $out   
    '';
  };

in mkDerivation {
  name = "baseweb-env";
  shellHook = "PATH=$PATH:${yarnPackage}/bin";
  buildInputs = [
    yarnPackage
    nixfmt
    spago
    purs
    yarn
    spago2nix
    make'
    dhall
    git
    nodejs
    purty
  ];
  buildCommand = ''
    cd ${cleanSrc}
    make check-format

    ls ${buildSrc}
    ls ${buildTest}
    ln -s ${buildExample} $out
  '';
}
