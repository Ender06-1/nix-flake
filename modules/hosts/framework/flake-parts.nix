{ inputs, ... }:
{
  flake.nixosConfigurations."framework" = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos."framework"
    ];
  };
}
