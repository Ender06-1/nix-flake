{
  inputs,
  self,
  lib,
  ...
}:
let
  mkUser = username: isAdmin: {
    nixos.${username} = {
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = lib.optional isAdmin "wheel";
      };

      home-manager.users.${username} = {
        imports = [
          self.modules.homeManager.${username}
        ];
      };
    };

    homeManager.${username} = {
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
    };
  };
in
{
  flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            networking.hostName = name;
          }
        ];
      };
    };

    mkAdminUser = username: mkUser username true;

    mkSimpleUser = username: mkUser username false;

    mkHomeManager = system: username: {
      ${username} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs { inherit system; };
        modules = [
          self.modules.homeManager.${username}
        ];
      };
    };

  };
}
