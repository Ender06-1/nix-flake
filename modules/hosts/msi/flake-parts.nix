{ inputs, ... }:
{
  flake.nixosConfigurations."msi" = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos."msi"
    ];
  };
}
