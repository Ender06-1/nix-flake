{ inputs, self, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = with inputs; [
        home-manager.nixosModules.home-manager
      ];

      home-manager.sharedModules = with self.modules.homeManager; [
        base
      ];

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        gc = {
          automatic = true;
          dates = "23:00";
        };
      };
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";

      networking.networkmanager.enable = true;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
      };

      documentation.dev.enable = true;

      environment.systemPackages = with pkgs; [
        man-pages
        man-pages-posix
        tree
        file
        git
        fzf
        btop
        fastfetch
        wget
        zip
        unzip
        neovim

        gcc16
        python314
      ];

      system.stateVersion = "25.05";
    };

  flake.modules.homeManager.base = {
    xdg = {
      userDirs.setSessionVariables = false;
      enable = true;
    };
  };
}
