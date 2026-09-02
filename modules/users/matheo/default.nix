{
  self,
  lib,
  ...
}:
let
  username = "matheo";
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
            docker
            flatpak
            games
            ssh
            waydroid
          ];

          users.users.${username}.extraGroups = [
            "docker"
            "kvm"
            "libvirtd"
          ];
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
            discord
            eza
            fish
            git
            kitty
            kolourpaint
            neovim
            obs-studio
            sqlitebrowser
            starship
            tmux
            vscode
            yazi
            zoxide
          ];

          programs.git = {
            settings.user = {
              name = "Mathéba";
              email = "ndxendernight@gmail.com";
            };
          };

          xdg.configFile = {
            "hypr".source = mkConfigSym "hypr";
          };
        };
    }
  ];
}
