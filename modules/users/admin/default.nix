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
        { pkgs, ... }:
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
            compose2nix
          ];

          programs.git = {
            settings.user = {
              name = "Admin";
              email = "ndxendernight@gmail.com";
            };
          };

          xdg = {
            configFile = {
              "nvim" = {
                source = ./dotfiles/nvim;
                recursive = true;
              };
              "fish" = {
                source = ./dotfiles/fish;
                recursive = true;
              };
              "starship.toml".source = ./dotfiles/starship.toml;
            };
            mimeApps.defaultApplicationPackages = [ pkgs.neovim-unwrapped ];
          };
        };
    }
  ];
}
