{ inputs, self, ... }:
{
  flake-file.inputs = {
    caelestia-shell = {
      url = "github:caelestia-dots/shell?ref=v2.5.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  flake.modules.nixos.hyprland = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      desktop
    ];

    home-manager.sharedModules = with self.modules.homeManager; [
      hyprland
    ];

    programs.hyprland.enable = true;
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        session_log = ".local/state/ly-session.log";
      };
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprsysteminfo
      app2unit
      cliphist
      inotify-tools
      libnotify
      brightnessctl
      pavucontrol
      playerctl
      papirus-icon-theme
      kdePackages.qt6ct
      kdePackages.qtsvg
      kdePackages.qtimageformats
      kdePackages.qtmultimedia
      kdePackages.qt5compat
      nwg-look
      adw-gtk3
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code

      poppler
      file-roller
      loupe
      nautilus
      papers
    ];
  };

  flake.modules.homeManager.hyprland =
    { pkgs, lib, ... }:
    {
      imports = with inputs; [
        caelestia-shell.homeManagerModules.default
      ];

      programs.caelestia = {
        enable = true;
        systemd.enable = false;

        cli.enable = true;
      };

      services.mpris-proxy.enable = true;

      home.pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;

        hyprcursor.enable = true;
      };

      xdg.mimeApps.defaultApplicationPackages = with pkgs; [
        poppler
        file-roller
        loupe
        nautilus
        papers
      ];
    };
}
