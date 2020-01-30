let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources.nixpkgs { };

  easy-purescript-nix = import sources.easy-purescript-nix { pkgs = nixpkgs; };

  yarn2nix = import sources.yarn2nix { pkgs = nixpkgs; };

in import ./nondefault.nix {
  mkDerivation = nixpkgs.stdenv.mkDerivation;
  nixfmt = nixpkgs.nixfmt;
  spago = easy-purescript-nix.spago;
  writeShellScriptBin = nixpkgs.writeShellScriptBin;
  purs = easy-purescript-nix.purs-0_13_4;
  yarn2nix = yarn2nix;
  yarn = nixpkgs.yarn;
  runCommand = nixpkgs.runCommand;
  spago2nix = easy-purescript-nix.spago2nix;
  fetchgit = nixpkgs.fetchgit;
  make = nixpkgs.gnumake;
  bash = nixpkgs.bash;
  nix-gitignore = nixpkgs.nix-gitignore;
  dhall = nixpkgs.dhall;
}
