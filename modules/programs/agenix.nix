{ inputs, ... }:
{
  flake.modules.nixos.agenix = {
    imports = with inputs; [
      agenix.nixosModules.default
    ];

    environment.systemPackages = with inputs; [
      agenix.packages.${system}.default
    ];

    age.secrets = {
      caddy.file = ../_secrets/caddy.age;
    };
  };
}
