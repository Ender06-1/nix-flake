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
            ssh
            games
            flatpak
            waydroid
            docker
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
          mkConfigSym =
            fileName:
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-flake/modules/users/${username}/dotfiles/${fileName}";
        in
        {
          imports = with self.modules.homeManager; [
            bat
            eza
            git
            yazi
            zoxide
            fish
            neovim
            tmux
            direnv
            kitty
            obs-studio
            vscode
            discord
            compose2nix
          ];

          programs.git = {
            settings.user = {
              name = "Mathéba";
              email = "ndxendernight@gmail.com";
            };
          };

          xdg = {
            configFile = {
              "fish/conf.d/colors.fish".source = mkConfigSym "fish/conf.d/colors.fish";
              "fish/functions/ltg".source = mkConfigSym "fish/functions/ltg.fish";
              "hypr".source = mkConfigSym "hypr";
              "nvim".source = mkConfigSym "nvim";
              "starship.toml".source = mkConfigSym "starship.toml";
            };
            mimeApps.defaultApplicationPackages = [ pkgs.neovim-unwrapped ];
          };

          programs.neovim.sideloadInitLua = true;
        };
    }
  ];
}
