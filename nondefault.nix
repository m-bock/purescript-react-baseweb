{ runCommand, mkDerivation, nixfmt, spago, writeShellScriptBin, purs, yarn2nix
, yarn }:

let
  purty-check = writeShellScriptBin "purty-check" ''
    for file in $SRCS ; do
    	ACTUAL=`cat $file`
    	EXPECTED=`purty $file`
    	if test "$EXPECTED" != "$ACTUAL" ; then
    		echo "$file not formatted.";
    	fi
    done
  '';

  purty-format = writeShellScriptBin "purty-format" ''
    for file in $SRCS ; do
        purty $file --write
    done
  '';

  yarnPackage = yarn2nix.mkYarnPackage {
    pname = "purescript-baseweb-dev";
    name = "purescript-baseweb-dev";
    version = "1.0.0";
    src = ./.;
    publishBinsFor = [ "purescript-psa" "parcel" ];

    packageJSON = ./package.json;
    yarnLock = ./yarn.lock;
  };

in mkDerivation {
  name = "baseweb-env";
  shellHook = "PATH=$PATH:${yarnPackage}/bin";
  buildInputs = [ nixfmt spago purty-check purty-format purs yarn ];
  buildCommand = "";
}
