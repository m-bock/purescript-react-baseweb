let
  sources =
    builtins.mapAttrs (_: value: import value { }) (import ./nix/sources.nix);

in import ./nondefault.nix {
  mkDerivation = sources.nixpkgs.stdenv.mkDerivation;
  nixfmt = sources.nixpkgs.nixfmt;
  spago = sources.easy-purescript-nix.spago;
  writeShellScriptBin = sources.nixpkgs.writeShellScriptBin;
  purs = sources.easy-purescript-nix.purs;
  yarn2nix = sources.yarn2nix;
  yarn = sources.nixpkgs.yarn;
  runCommand = sources.nixpkgs.runCommand;
}
