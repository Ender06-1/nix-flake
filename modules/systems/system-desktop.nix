{ self, ... }:
{
  flake.modules.nixos.system-desktop =
    { pkgs, ... }:
    {
      imports = with self.modules.nixos; [
        system-default
      ];

      home-manager.sharedModules = with self.modules.homeManager; [
        system-desktop
      ];

      hardware.graphics.enable = true;

      hardware.bluetooth = {
        enable = true;
        settings = {
          General = {
            Expermental = true;
          };
        };
      };

      nixpkgs.config.permittedInsecurePackages = [
        "electron-39.8.10"
      ];

      environment.systemPackages = with pkgs; [
        # bitwarden-desktop
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

  flake.modules.homeManager.system-desktop =
    { pkgs, ... }:
    {
      xdg = {
        enable = true;
        mimeApps = {
          defaultApplicationPackages = with pkgs; [
            vlc
            libreoffice-fresh
            firefox
          ];
        };
      };
    };
}
