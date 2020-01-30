{ runCommand, mkDerivation, nixfmt, spago, writeShellScriptBin, purs, yarn2nix
, yarn, spago2nix, fetchgit, make, bash, nix-gitignore, dhall }:

let
  purty-check = writeShellScriptBin "purty-check" ''
    for file in $@ ; do
    	ACTUAL=`cat $file`
    	EXPECTED=`purty $file`
    	if test "$EXPECTED" != "$ACTUAL" ; then
    		echo "$file not formatted.";
    	fi
    done
  '';

  purty-format = writeShellScriptBin "purty-format" ''
    for file in $@ ; do
        purty $file --write
    done
  '';

  dhall-check = writeShellScriptBin "dhall-check" ''
    for file in $@ ; do
        cat $file | dhall format --check
    done
  '';

  dhall-format = writeShellScriptBin "dhall-format" ''
    for file in $@ ; do
        dhall format --inplace $file
    done
  '';

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

  spagoPkgs = import ./spago-packages.nix {
    pkgs = {
      stdenv = { inherit mkDerivation; };
      inherit fetchgit;
      inherit runCommand;
    };
  };

  spagoSrcs = runCommand "src" { } ''
    mkdir $out
    shopt -s globstar
    cp -rf ${./src}/* -t $out
    cp -rf ${./example}/* -t $out
    cp -rf ${./test}/* -t $out
  '';
  /* spagoOutput = spagoPkgs.mkBuildProjectOutput {
       src = spagoSrcs;
       inherit purs;
     };
  */
  cleanSrc = runCommand "src" { } ''
    mkdir $out
    cp -r ${nix-gitignore.gitignoreSource [ ] ./.}/* -t $out
    ln -s ${yarnModules}/node_modules $out/node_modules
  '';

  # ln -s ${spagoOutput} $out/output

in mkDerivation {
  name = "baseweb-env";
  shellHook = "PATH=$PATH:${yarnPackage}/bin";
  buildInputs = [
    nixfmt
    spago
    purty-check
    purty-format
    dhall-check
    dhall-format
    purs
    yarn
    spago2nix
    make
    dhall
  ];
  buildCommand = ''
    TMP=`mktemp -d`

    cd $TMP

    PATH=$PATH:${yarnPackage}/bin

    cp -r ${cleanSrc}/* .

    bash ${spagoPkgs.installSpagoStyle}

    make SHELL=${bash}/bin/bash

    mkdir $out

    cp -r dist/* -t $out
  '';
}
