{
  flake.modules.homeManager.vlc = { pkgs, ... }: {
    home.packages = with pkgs; [
      vlc
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        vlc
      ];
    };
  };
}
