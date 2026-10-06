{
  description = "ola em Nix";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }:
    let
      stm = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${stm};
    in {
      # nix build
      packages.${stm}.default = pkgs.hello;
      # nix develop
      devShells.${stm}.default = pkgs.mkShell { packages = [ pkgs.cowsay ]; };
    };
}
