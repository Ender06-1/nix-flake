{
  flake.modules.homeManager.starship = { config, ... }: {
    programs.starship = {
      enable = true;
      enableTransience = true;
    };

    xdg.configFile."starship.toml" = config.lib.my.mkConfigSym "programs/starship/starship.toml";
  };
}
