{ inputs, ... }:
{
  flake.modules.nixos.hyprland = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.hyprland
    ];

    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        session_log = ".local/state/ly-session.log";
      };
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    security.polkit.enable = true;

  };

  flake.modules.homeManager.hyprland =
    { pkgs, lib, ... }:
    {
      programs.caelestia = {
        enable = true;
        systemd.enable = false;

        cli.enable = true;
        settings = {
          general.apps = {
            terminal = [ "kitty" ];
            audio = [ "pavucontrol" ];
            playback = [ "mpv" ];
            explorer = [ "nautilus" ];
          };
          paths.sessionGif = "";
          services = {
            useFahrenheit = false;
            useTwelveHourClock = false;
          };
          bar.status.showBattery = lib.mkDefault false;
        };
      };

      home.pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;

        hyprcursor.enable = true;
      };

      fonts.fontconfig.enable = true;

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        configFile."hypr" = {
          source = ./configs/hypr;
          recursive = true;
        };
      };

      home.packages = with pkgs; [
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
      ];
    };
}
