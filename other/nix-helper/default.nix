{pkgs?(import <nixpkgs>(builtins.currentSystem)}:pkgs.stdenv.mkDerivation{
  name="neovim-nix-helper";

  version="0.1.0";
  src=./neovimnixhelper.c;
  dontUnpack=true;
  buildPhase = "gcc -O2 -s $src -o nixneovimmanager";
  installPhase = "mkdir -p $out/bin; mv nixneovimmanager $out/bin/nix-helper";
}

