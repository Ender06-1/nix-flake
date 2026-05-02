{ inputs, ... }:
{
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
