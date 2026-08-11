# DO NOT EDIT: file automatically generated. use `nix run .#write-flake
{
  description = "Ender06-1's flake";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        darwin.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell?ref=v2.3.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
}
