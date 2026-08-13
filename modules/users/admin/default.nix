{ self, lib, ... }:
let
  username = "admin";
in
{
  flake.homeConfigurations = self.lib.mkHomeManager "x86_64-linux" username;

  flake.modules = lib.mkMerge [
    (self.lib.mkUser username true)

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
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPybOZB+lmPWgxHv5boGPtlMz6QQ8T881/Yzbk/M36z"
            ];
          };

          services.openssh.settings.AllowUsers = [ "admin" ];
        };

      homeManager.${username} =
        { config, pkgs, ... }:
        let
          mkConfigSym = configName: config.lib.my.mkConfigSym "users/${username}/dotfiles/${configName}";
        in
        {
          imports = with self.modules.homeManager; [
            bat
            compose2nix
            direnv
            eza
            fish
            git
            neovim
            restic
            tmux
            yazi
            zoxide
          ];

          programs.git = {
            settings.user = {
              name = "Admin";
              email = "ndxendernight@gmail.com";
            };
          };

          xdg = {
            configFile = {
              "starship.toml".source = mkConfigSym "starship.toml";
            };
          };
        };
    }
  ];
}
