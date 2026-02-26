{ inputs, ... }:
{
  flake.modules.nixos.desktop-apps = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.desktop-apps
    ];

    programs.steam.enable = true;
  };

  flake.modules.homeManager.desktop-apps =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        themeFile = "OneDark-Pro";
        font.name = "FiraCode Nerd Font";
      };

      programs.obs-studio.enable = true;

      programs.vscode.enable = true;

      home.packages = with pkgs; [
        poppler
        bitwarden-desktop
        discord
        file-roller
        libreoffice-fresh
        loupe
        nautilus
        papers
        vlc
      ];

      xdg = {
        enable = true;
        mimeApps = {
          enable = true;
          defaultApplicationPackages = with pkgs; [
            papers
            loupe
            vlc
            libreoffice-fresh
            file-roller
          ];
        };
      };
    };
}
