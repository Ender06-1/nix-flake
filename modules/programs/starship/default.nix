{
  flake.modules.homeManager.starship = { config, ... }: {
    programs.starship = {
      enable = true;
      enableTransience = true;
    };

    xdg.configFile."starship.toml".source = config.lib.my.mkConfigSym "programs/starship/starship.toml";
  };
}
