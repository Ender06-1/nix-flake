{ inputs, ... }:
{
  flake.nixosConfigurations."fujitsu" = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos."fujitsu"
    ];
  };

  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };
}
