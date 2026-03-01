{ inputs, ... }:
{
  flake.nixosConfigurations."fujitsu" = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos."fujitsu"

      inputs.agenix.nixosModules.default
    ];
  };
}
