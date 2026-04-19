{ inputs, ... }:
{
  flake.modules.nixos.system-default =
    { pkgs, ... }:
    {
      imports = with inputs; [
        home-manager.nixosModules.home-manager
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
        file
        ffmpeg
        p7zip
        jq
        resvg
        imagemagick
        unzip
        zip

        gcc15
        python314
      ];

      system.stateVersion = "25.05";
    };
}
