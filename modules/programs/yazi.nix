{
  flake.modules.homeManager.yazi = {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
