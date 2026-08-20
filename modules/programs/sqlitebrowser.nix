{
  flake.modules.homeManager.sqlitebrowser = { pkgs, ... }: {
    home.packages = with pkgs; [
      sqlitebrowser
    ];
  };
}
