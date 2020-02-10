{ runCommand, mkDerivation, nixfmt, spago, writeShellScriptBin, purs, yarn2nix
, yarn, spago2nix, fetchgit, make, bash, nix-gitignore, dhall, git, nodejs, pkgs
}:

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
    publishBinsFor = [ "purescript-psa" "parcel" ];
  });

  yarnModules = yarn2nix.mkYarnModules packageJsonMeta;

  cleanSrc = runCommand "src" { } ''
    mkdir $out
    cp -r ${nix-gitignore.gitignoreSource [ ] ./.}/* -t $out
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

      ln -s ${./Makefile} Makefile
      ln -s ${./src} src

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

      ln -s ${./Makefile} Makefile
      ln -s ${./src} src
      ln -s ${./test} test
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

      ln -s ${./Makefile} Makefile
      ln -s ${./src} src
      ln -s ${./example} example
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
  buildInputs = [ nixfmt spago purs yarn spago2nix make' dhall git nodejs ];
  buildCommand = ''
    cd ${cleanSrc}
    make check-format

    ls ${buildSrc}
    ls ${buildTest}
    ln -s ${buildExample} $out
  '';
}
