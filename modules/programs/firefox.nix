{
  flake.modules.homeManager.firefox = { pkgs, config, ... }: {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        firefox
      ];
    };
  };
}
