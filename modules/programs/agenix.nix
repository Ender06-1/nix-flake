{ inputs, ... }:
{
  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
      };
    };
  };

  flake.modules.nixos.agenix =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = with inputs; [
        agenix.nixosModules.default
      ];

      environment.systemPackages = with inputs; [
        agenix.packages.${system}.default
      ];
    };
}
