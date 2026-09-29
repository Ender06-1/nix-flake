{
  flake.modules.homeManager.libreoffice = { pkgs, ... }: {
    home.packages = with pkgs; [
      libreoffice-fresh
    ];

    xdg.mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        libreoffice-fresh
      ];
    };
  };
}
