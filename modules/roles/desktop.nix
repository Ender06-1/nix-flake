{ self, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        base
      ];

      home-manager.sharedModules = with self.modules.homeManager; [
        desktop
      ];

      hardware.graphics.enable = true;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };

      security.polkit.enable = true;

      hardware.bluetooth = {
        enable = true;
        settings = {
          General = {
            Expermental = true;
          };
        };
      };

      environment.systemPackages = with pkgs; [
        bitwarden-desktop
        libreoffice-fresh
        vlc
        google-chrome
      ];

      programs.firefox.enable = true;

      services = {
        udisks2.enable = true;
        gvfs.enable = true;
      };
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      fonts.fontconfig.enable = true;

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        mimeApps = {
          enable = true;
          defaultApplicationPackages = with pkgs; [
            vlc
            libreoffice-fresh
            firefox
          ];
        };
      };
    };
}
