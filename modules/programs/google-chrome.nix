{
  flake.modules.homeManager.google-chrome = { pkgs, ... }: {
    home.packages = with pkgs; [
      google-chrome
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        google-chrome
      ];
    };
  };
}
