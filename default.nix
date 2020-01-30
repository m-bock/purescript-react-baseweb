let
  sources =
    builtins.mapAttrs (_: value: import value { }) (import ./nix/sources.nix);

in import ./nondefault.nix {
  mkDerivation = sources.nixpkgs.stdenv.mkDerivation;
  nixfmt = sources.nixpkgs.nixfmt;
  spago = sources.easy-purescript-nix.spago;
  writeShellScriptBin = sources.nixpkgs.writeShellScriptBin;
  purs = sources.easy-purescript-nix.purs-0_13_4;
  yarn2nix = sources.yarn2nix;
  yarn = sources.nixpkgs.yarn;
  runCommand = sources.nixpkgs.runCommand;
  spago2nix = sources.easy-purescript-nix.spago2nix;
  fetchgit = sources.nixpkgs.fetchgit;
  make = sources.nixpkgs.gnumake;
  bash = sources.nixpkgs.bash;
  nix-gitignore = sources.nixpkgs.nix-gitignore;
  dhall = sources.nixpkgs.dhall;
}
