{
  description = "neovim-nix-helper - Tiny C wrapper for nix commands used by ONNV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Supported systems - add more if you ever need them
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # Helper function to generate packages for every system
      forEachSystem = f:
        nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      packages = forEachSystem (pkgs:
        {
          default = import ./default.nix { inherit pkgs; };
        }
      );
    };
}
