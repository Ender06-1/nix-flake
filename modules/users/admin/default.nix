{ self, lib, ... }:
let
  username = "admin";
in
{
  flake.homeConfigurations = self.lib.mkHomeManager "x86_64-linux" username;

  flake.modules = lib.mkMerge [
    (self.lib.mkAdminUser username)

    {
      nixos.${username} =
        { pkgs, ... }:
        {
          imports = with self.modules.nixos; [
            ssh
            docker
          ];

          users.users.${username} = {
            extraGroups = [
              "docker"
            ];
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANbfngrtyAT/WLnWQhQftePLzPbqnA65gokQWyP8zdt"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZySQNthwFjyswLFStt0KXDtBqX+qLyyianZhtzMqt2"
            ];
          };

          services.openssh.settings.AllowUsers = [ "admin" ];
        };

      homeManager.${username} =
        { config, pkgs, ... }:
        {
          imports = with self.modules.homeManager; [
            bat
            compose2nix
            direnv
            eza
            fish
            starship
            git
            neovim
            restic
            tmux
            yazi
            zoxide
            immich-go
            hdparm
            zfs
          ];

          programs.git = {
            settings.user = {
              name = "Admin";
              email = "ndxendernight@gmail.com";
            };
          };

        };
    }
  ];
}
